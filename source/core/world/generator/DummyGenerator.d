module core.world.generator.DummyGenerator;

import core.world.utils.GlobalCubeCoordinates;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

class DummyGenerator(T) : IGenerator!T {
  Nullable!Cube getCube(T coors) {
    return Nullable!Cube(new Cube());
  }
}
