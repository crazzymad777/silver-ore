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

  private DataFurniture doorData;
  private DataFurniture[] furniture;
  Mt19937_64 rnd;
  this(ref Mt19937_64 rnd) {
    import std.conv: to;
    this.rnd = rnd;
    x = uniform(0, 256, rnd);
    y = uniform(0, 256, rnd);
    z = 128;
    width = uniform(4, 8, rnd);
    height = uniform(4, 8, rnd);

    basement = to!bool(uniform!"[]"(0, 1, rnd));
    loft = to!bool(uniform!"[]"(0, 1, rnd));

    cornersX = [x-width+1, x+width-1];
    cornersY = [y-height+1, y+height-1];

    stairsX = cornersX[uniform(0, 2)];
    stairsY = cornersY[uniform(0, 2)];

    if (hasLoft() || hasBasement()) {
      furniture ~= DataFurniture(stairsX, stairsY, z, "Stairs");
    }
    if (hasLoft()) {
      furniture ~= DataFurniture(stairsX, stairsY, z + 1, "Stairs");
    }
    if (hasBasement()) {
      furniture ~= DataFurniture(stairsX, stairsY, z - 1, "Stairs");
    }

    auto table = newFurniture("Table");
    if (!table.isNull) {
      newChair("Chair", table.get);
    }
    newFurniture("Chest");
    newFurniture("Closet");
    newFurniture("Bed");
    doorData = newDoor();
  }

  Nullable!DataFurniture newFurniture(string type) {
    int i = 0;
    int x, y, z;

    do {
      x = uniform(this.x-width+1, this.x+width, rnd);
      y = uniform(this.y-height+1, this.y+height, rnd);

      int minZ = this.z;
      if (hasBasement()) {
        minZ = this.z-1;
      }

      int maxZ = this.z+1;
      if (hasLoft()) {
        maxZ = this.z+1+1;
      }
      z = uniform(minZ, maxZ, rnd);

      bool collision = false;
      foreach (element; furniture) {
        if (element.x == x && element.y == y && element.z == z) {
          collision = true;
        }
      }

      if (!collision) {
        auto data = DataFurniture(x, y, z, type);
        furniture ~= data;
        return Nullable!DataFurniture(data);
      }
      i++;
    } while(i < 10);

    return Nullable!DataFurniture();
  }

  // Supposed that chair generated right after table generation. So collision not checked.
  Nullable!DataFurniture newChair(string type, DataFurniture follow) {
    import std.typecons;
    auto coors = [tuple(follow.x-1, follow.y),
                  tuple(follow.x+1, follow.y),
                  tuple(follow.x, follow.y+1),
                  tuple(follow.x, follow.y-1)];

    int offset = uniform(0, 4, rnd);
    Nullable!(Tuple!(int, int)) pair;

    for (int i = 0; i < 4; i++) {
      auto x = coors[(offset+i)%4][0];
      auto y = coors[(offset+i)%4][1];
      if (!isWall(ClusterCubeCoordinates(x, y, z))) {
        pair = Nullable!(Tuple!(int, int))(coors[(offset+i)%4]);
        break;
      }
    }

    if (!pair.isNull) {
      int x = pair.get[0];
      int y = pair.get[1];
      int z = follow.z;
      auto data = DataFurniture(x, y, z, type);
      furniture ~= data;
      return Nullable!DataFurniture(data);
    }

    return Nullable!DataFurniture();
  }

  DataFurniture newDoor() {
    import std.conv: to;
    int x, y;

    bool randomBool1 = to!bool(uniform!"[]"(0, 1, rnd));
    bool randomBool2 = to!bool(uniform!"[]"(0, 1, rnd));
    if (randomBool1) {
      x = uniform(this.x-width+1, this.x+width, rnd);

      if (randomBool2) {
        y = this.y-height;
      } else {
        y = this.y+height;
      }
    } else {
      y = uniform(this.y-height+1, this.y+height, rnd);

      if (randomBool2) {
        x = this.x-width;
      } else {
        x = this.x+width;
      }
    }
    auto data = DataFurniture(x, y, z, "Door");
    furniture ~= data;
    return data;
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

    if (doorData.x != coors.x || doorData.y != coors.y || doorData.z != coors.z) {
      if (abs(cast(int) (coors.x) - x) == width || abs(cast(int) coors.y - y) == height) {
        if (coors.z == z || (coors.z == z + 1 && loft) || (coors.z == z - 1 && basement)) {
          return true;
        }
      }
    }
    return false;
  }

  Furniture getFurniture(ClusterCubeCoordinates coors) {
    import core.game.furniture.Stairs;
    import core.game.furniture.Bed;
    import core.game.furniture.Chair;
    import core.game.furniture.Table;
    import core.game.furniture.Closet;
    import core.game.furniture.Chest;
    import core.game.furniture.Door;

    foreach (element; furniture) {
      if (coors.x == element.x && coors.y == element.y && coors.z == element.z) {
        if (element.furniture == "Stairs") {
          return new Stairs();
        }
        if (element.furniture == "Table") {
          return new Table();
        }
        if (element.furniture == "Chair") {
          return new Chair();
        }
        if (element.furniture == "Bed") {
          return new Bed();
        }
        if (element.furniture == "Closet") {
          return new Closet();
        }
        if (element.furniture == "Chest") {
          return new Chest();
        }
        if (element.furniture == "Door") {
          return new Door();
        }
      }
    }
    return null;
  }

  Material getWall(ClusterCubeCoordinates coors) {
    auto dispenser = Dispenser.get();
    if (isWall(coors)) {
      return dispenser.getMaterial("Wood");
    }
    return dispenser.getMaterial("Air");
  }
}
