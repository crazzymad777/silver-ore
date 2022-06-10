module core.world.generator.town.HumanTown;

import core.world.utils.ClusterCubeCoordinates;
import std.typecons: Nullable;
import core.world.Cube;
import core.world.IGenerator;

class HumanTown : IGenerator!ClusterCubeCoordinates {
  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    return Nullable!Cube(null);
  }
}
