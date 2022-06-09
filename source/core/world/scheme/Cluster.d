module core.world.scheme.Cluster;

/// Cluster contains 16x16x16 chunks
class Cluster {
  import core.world.utils.GlobalCubeCoordinates;
  import core.world.map.ClusterId;
  import core.world.scheme.Chunk;
  import core.world.IGenerator;
  import core.world.Cube;

  private ClusterId id;
  private IGenerator generator;
  private Chunk[uint] chunks;
  this(ClusterId id, IGenerator generator) {
    this.id = id;
    this.generator = generator;
  }

  private Cube[GlobalCubeCoordinates] cache;
  Cube getCube(GlobalCubeCoordinates coors) {
    // cluster -> chunk -> cube
    auto cube = (coors in cache);
    if (cube is null) {
      cache[coors] = new Cube();
      return cache[coors];
    }
    return *cube;
  }

  ulong cubesLoaded() {
    return cache.length;
  }
}
