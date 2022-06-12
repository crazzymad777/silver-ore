module core.world.generator.SeaGenerator;

import core.world.utils.ClusterCubeCoordinates;
import core.game.material.Dispenser;
import core.game.material.Material;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

import core.world.generator.ClusterOreGeneratorId;
import core.world.generator.ClusterOreGenerator;
import core.world.map.ClusterId;
import core.world.Map;

class SeaGenerator : IGenerator!ClusterCubeCoordinates {
  ClusterOreGenerator oreGenerator;
  private ClusterId[] neighbourhood;
  private Map map;
  this(ClusterId id, ulong seed, Map map) {
    oreGenerator = new ClusterOreGenerator(ClusterOreGeneratorId(id, seed));
    neighbourhood = id.getNeighbourhood();
    this.map = map;
  }

  private int level = 128;

  private int getDepth(ClusterCubeCoordinates coors) {
    import core.world.map.Tile;
    import std.algorithm;
    import std.math;
    import std.conv;

    assert(coors.x >= 0);
    assert(coors.y >= 0);

    auto offsetX = to!int(coors.x)-128;
    auto offsetY = to!int(coors.y)-128;

    // seems working
    double relation;
    if (offsetY == 0) {
      relation = 2;
    } else {
      relation = offsetX / offsetY;
    }

    auto dirX = 0;
    auto dirY = 0;
    if (abs(relation) >= 1) {
      dirX = sgn(offsetX);
    } else {
      dirY = sgn(offsetY);
    }

    int dir;
    if (dirX == 0 && dirY == -1) {
      dir = 0;
    } else if (dirX == 1) {
      dir = 2;
    } else if (dirX == 0 && dirY == 1) {
      dir = 4;
    } else {
      dir = 6;
    }

    int dis;
    if (Tile.isSea(map.getTileType(neighbourhood[dir]))) {
      dis = 0;
    } else {
      int disX = abs(offsetX);
      int disY = abs(offsetY);
      dis = max(-disX-disY, -64);
    }

    return 64+dis;
  }

  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    auto d = Dispenser.get();

    int depth = getDepth(coors);
    int bottom = level-depth;

    Material floor = d.getMaterial("Void");
    Material wall = d.getMaterial("Void");
    if (coors.z > level) {
      wall = d.getMaterial("Air");
      floor = d.getMaterial("Air");
    } else if (coors.z == level) {
      wall = d.getMaterial("Air");
      floor = d.getMaterial("Water");
    } else if (bottom < coors.z && coors.z < level) {
      floor = d.getMaterial("Water");
      wall = d.getMaterial("Water");
    } else if (bottom-4 <= coors.z && coors.z <= bottom) {
      wall = d.getMaterial("Silt");
      floor = d.getMaterial("Silt");
      auto x = coors.x & 0b11111111;
      auto y = coors.y & 0b11111111;
      if (x < 5 || x > 250 || y < 5 || y > 250) {
        if (depth < 5) {
          wall = d.getMaterial("Sand");
          floor = d.getMaterial("Sand");
        }
      }
    } else if (bottom-4 > coors.z) {
      auto cube = oreGenerator.getCube(coors);
      if (cube.get !is null) {
        return cube;
      }
      wall = d.getMaterial("Stone");
      floor = d.getMaterial("Stone");
    }
    return Nullable!Cube(new Cube(wall, floor));
  }

// TODO: change type to ClusterCubeCoordinates!!
/* override fun getCube(coors: GlobalCubeCoordinates): Cube {
var floor: Material
var wall: Material = Material.AIR
val level = getLevel()

val ucoors = GlobalCubeCoordinates(((coors.x.toULong())%256u).toLong(),
                     ((coors.y.toULong())%256u).toLong(), coors.z)
val depth = getDepth(ucoors)
val bottom = level-depth

if (ucoors.z in bottom..level) {
floor = Material.WATER
} else if (ucoors.z <= bottom-4) {
@Suppress("NAME_SHADOWING") val cube = generator.oreGenerator.getCube(coors)
if (cube != null) {
return cube
}
wall = Material.STONE
floor = Material.STONE
} else if (coors.z > level) {
wall = Material.AIR
floor = Material.AIR
} else {
wall = Material.SILT
floor = Material.SILT
if (ucoors.x%256 < 5 || ucoors.x%256 > 250 || ucoors.y%256 < 5 || ucoors.y%256 > 250) {
if (depth < 5) {
wall = Material.SAND
floor = Material.SAND
}
}
}
return Cube(wall, floor)
} */
}
