module custom.paladin.world.Generator;

import core.world.utils.GlobalCubeCoordinates;
import core.world.Cube;

class Generator {
  private Cube[GlobalCubeCoordinates] cubes;
  Cube getCube(GlobalCubeCoordinates coors) {
    auto cube_ptr = (coors in cubes);
    if (cube_ptr is null) {
      auto cube = generateCube(coors);
      cubes[coors] = cube;
      return cube;
    }
    return *cube_ptr;
  }

  Cube generateCube(GlobalCubeCoordinates coors) {
    import core.game.material.Dispenser;
    import std.math;

    if (abs(coors.x) <= 8) {
      if (abs(coors.y) <= 8) {
        if (abs(coors.x) == 8 || abs(coors.y) == 8) {
          return new Cube(Dispenser.get().getMaterial("Stone"), Dispenser.get().getMaterial("Stone"));
        }
      }
    }
    return new Cube(Dispenser.get().getMaterial("Air"), Dispenser.get().getMaterial("Stone"));
  }
}
