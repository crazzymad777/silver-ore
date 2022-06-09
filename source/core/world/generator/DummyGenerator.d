module core.world.generator.DummyGenerator;

import core.world.utils.GlobalCubeCoordinates;
import core.game.material.Dispenser;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

class DummyGenerator(T) : IGenerator!T {
  Nullable!Cube getCube(T coors) {
    auto dispenser = Dispenser.get();
    return Nullable!Cube(new Cube(
        dispenser.getMaterial("Grass"),
        dispenser.getMaterial("Grass")
    ));
  }
}
