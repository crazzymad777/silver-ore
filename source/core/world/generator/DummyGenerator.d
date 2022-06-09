module core.world.generator.DummyGenerator;

import core.world.utils.GlobalCubeCoordinates;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

class DummyGenerator : IGenerator {
  Nullable!Cube getCube(GlobalCubeCoordinates coors) {
    return Nullable!Cube(new Cube());
  }
}
