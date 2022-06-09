module core.world.World;

import core.world.utils.GlobalCubeCoordinates;
import core.world.WorldConfig;
import core.world.Cube;

class World {
  import core.world.Map;

  private WorldConfig config;
  private Map map;
  this(WorldConfig config = new WorldConfig()) {
    this.config = config;
    this.map = new Map(config.seed);
  }

  private Cube[GlobalCubeCoordinates] cache;

  Cube getCube(GlobalCubeCoordinates coors) {
    auto cube = (coors in cache);
    if (cube is null) {
      cache[coors] = new Cube();
      return cache[coors];
    }
    return *cube;
  }

  // return chunk
  int getChunkByCoordinates(GlobalCubeCoordinates coors) {
    return 0;
  }

  int clustersLoaded() {
    return 1;
  }

  int chunksLoaded() {
    return 1;
  }

  ulong cubesLoaded() {
    return cache.length;
  }

  GlobalCubeCoordinates getDefaultCoordinates() {
    return GlobalCubeCoordinates(0, 0, 0);
  }
}
