module core.world.generator.i1;

import core.world.utils.ClusterCubeCoordinates;
import core.game.material.Dispenser;
import core.game.material.Material;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

import core.world.generator.ClusterOreGeneratorId;
import core.world.generator.ClusterOreGenerator;
import core.world.map.ClusterId;

class i1 : IGenerator!ClusterCubeCoordinates {
  ClusterOreGenerator oreGenerator;
  this(ClusterId id, ulong seed) {
    oreGenerator = new ClusterOreGenerator(ClusterOreGeneratorId(id, seed));
  }

  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    auto d = Dispenser.get();

    Material floor;
    Material wall = d.getMaterial("Air");
    if (coors.z == 128L) {
      floor = d.getMaterial("Grass");
    } else if (coors.z <= 124L) {
      auto cube = oreGenerator.getCube(coors);
      if (cube.get !is null) {
        return cube;
      }
      wall = d.getMaterial("Stone");
      floor = d.getMaterial("Stone");
    } else if (coors.z > 128L) {
      wall = d.getMaterial("Air");
      floor = d.getMaterial("Air");
    } else {
      wall = d.getMaterial("Soil");
      floor = d.getMaterial("Soil");
    }
    return Nullable!Cube(new Cube(wall, floor));
  }
}

/* private val flatWorld = World(WorldConfig(generatorName = "flat"))

@Test fun testFlatWorld() {
    // randomize x and y
    val getCube: (Long) -> Cube = {
        flatWorld.getCube(GlobalCubeCoordinates(Random.nextLong(0, 255), Random.nextLong(0, 255), it))
    }

    assertEquals("STONE:STONE", getCube(124).displayTest())
    assertEquals("SOIL:SOIL", getCube(125).displayTest())
    assertEquals("AIR:GRASS", getCube(128).displayTest())
    assertEquals("AIR:AIR", getCube(130).displayTest())
} */
