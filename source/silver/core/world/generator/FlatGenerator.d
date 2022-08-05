module core.world.generator.FlatGenerator;

import core.world.utils.ClusterCubeCoordinates;
import core.game.material.Dispenser;
import core.game.material.Material;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

import core.world.generator.ClusterOreGeneratorId;
import core.world.generator.ClusterOreGenerator;
import core.world.map.ClusterId;

class FlatGenerator : IGenerator!ClusterCubeCoordinates {
  ClusterOreGenerator oreGenerator;
  enum TYPE {
    GRASS,
    SAND
  }
  private TYPE type;
  this(ClusterId id, ulong seed, TYPE type = TYPE.GRASS) {
    oreGenerator = new ClusterOreGenerator(ClusterOreGeneratorId(id, seed));
    this.type = type;
  }

  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    auto d = Dispenser.get();

    Material floor;
    Material wall = d.getMaterial("Air");
    if (coors.z == 128L) {
      floor = d.getMaterial(type == TYPE.GRASS ? "Grass" : "Sand");
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
      wall = d.getMaterial(type == TYPE.GRASS ? "Soil" : "Sand");
      floor = d.getMaterial(type == TYPE.GRASS ? "Soil" : "Sand");
    }
    return Nullable!Cube(new Cube(wall, floor));
  }
}

/* private unittest {
  import std.typecons;
  auto generator = new FlatGenerator(ClusterId(0, 0), 0);
  auto getCube(int z) {
    import std.random;
    auto coors = ClusterCubeCoordinates(uniform(0, 256), uniform(0, 256), z);
    return generator.getCube(coors);
  }

  auto expected = [tuple!(Dispenser.get().getMaterial("Stone"), Dispenser.get().getMaterial("Stone"))];
} */

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
