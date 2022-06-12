module core.world.generator.town.Building;

import std.typecons: Nullable;

class Building {
  import core.world.utils.ClusterCubeCoordinates;
  import core.game.material.Dispenser;
  import core.game.material.Material;
  import core.game.Furniture;

  import std.random;
  bool ignored = false;
  int x, y, z;
  int width, height;

  private bool basement = false;
  private bool loft = false;
  bool hasBasement() { return basement; }
  bool hasLoft() { return loft; }

  private int[] cornersX;
  private int[] cornersY;
  private int stairsX;
  private int stairsY;

  struct DataFurniture {
    int x, y, z;
    string furniture = "null";
  }

  this(ref Mt19937_64 rnd) {
    import std.conv: to;
    x = uniform(0, 256, rnd);
    y = uniform(0, 256, rnd);
    z = 128;
    width = uniform(4, 8, rnd);
    height = uniform(4, 8, rnd);
    basement = to!bool(uniform!"[]"(0, 1));
    loft = to!bool(uniform!"[]"(0, 1));
    cornersX = [x-width+1, x+width-1];
    cornersY = [y-height+1, y+height-1];
    stairsX = cornersX[uniform(0, 2)];
    stairsY = cornersY[uniform(0, 2)];
  }


  bool check(ClusterCubeCoordinates coors) {
    import std.math, std.conv: to;

    if (abs(to!int(coors.x)-x) <= width && abs(to!int(coors.y)-y) <= height) {
      if (coors.z == z || (coors.z == z+1 && loft) || (coors.z == z-1 && basement)) {
        return true;
      }
    }
    return false;
  }

  bool isWall(ClusterCubeCoordinates coors) {
    import std.math, std.conv: to;

    /* if (doorData.x != x || doorData.y != y || doorData.z != z) { */
      if (abs(to!int(coors.x) - x) == width || abs(to!int(coors.y) - y) == height) {
        if (coors.z == z || (coors.z == z + 1 && loft) || (coors.z == z - 1 && basement)) {
          return true;
        }
      }
    /* } */
    return false;
  }

  Furniture getFurniture(ClusterCubeCoordinates coors) {
    return null;
    /* if (this.stairsX == x && this.stairsY == y && (this.hasLoft() || this.hasBasement())) {
      return Stairs()
    }

    for (element in furniture) {
      if (x == element.x && y == element.y && z == element.z) {
        when (element.furniture) {
          "Stairs" -> {
          return Stairs()
          }
          "Table" -> {
          return Table()
          }
          "Chair" -> {
          return Chair()
          }
          "Bed" -> {
          return Bed()
          }
          "Closet" -> {
          return Closet()
          }
          "Chest" -> {
          return Chest()
          }
          "Door" -> {
          return Door()
          }
        }
      }
    }

    return null */
  }

  Material getWall(ClusterCubeCoordinates coors) {
    auto dispenser = Dispenser.get();
    if (isWall(coors)) {
      return dispenser.getMaterial("Wood");
    }
    return dispenser.getMaterial("Air");
  }
}
