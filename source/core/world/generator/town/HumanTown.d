module core.world.generator.town.HumanTown;

import core.world.utils.ClusterCubeCoordinates;
import std.typecons: Nullable;
import core.world.Cube;
import core.world.IGenerator;

class HumanTown : IGenerator!ClusterCubeCoordinates {
  import core.world.generator.town.BuildingGenerator;
  import std.random;
  BuildingGenerator generator;

  this(ref Mt19937_64 rnd) {
    generator = new BuildingGenerator(rnd);
  }

  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    return generator.getCube(coors);
  }
}
