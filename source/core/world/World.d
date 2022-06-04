module core.world.World;

import core.world.Cube;
import core.world.utils;

class World {
  private Cube[GlobalCubeCoordinates] cache;

  Cube getCube(GlobalCubeCoordinates coors) {
    auto cube = (coors in cache);
    if (cube is null) {
      cache[coors] = new Cube();
      return cache[coors];
    }
    return *cube;
  }

  GlobalCubeCoordinates getDefaultCoordinates() {
    return GlobalCubeCoordinates(0, 0, 0);
  }
}
