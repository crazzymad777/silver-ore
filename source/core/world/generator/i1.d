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
  import core.world.generator.town.HumanTown;

  ClusterOreGenerator oreGenerator;
  HumanTown town;
  this(ClusterId id, ulong seed) {
    import core.world.utils.Seed: make, Random;
    import std.format;

    oreGenerator = new ClusterOreGenerator(ClusterOreGeneratorId(id, seed));
    auto town_seed = make(format("%d:i1:%d:%d", seed, id.getSignedX(), id.getSignedY()));
    auto rnd = Random(town_seed);
    town = new HumanTown(rnd);
  }

  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    auto townCube = town.getCube(coors);
    if (townCube.get !is null) {
      return townCube;
    }

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
