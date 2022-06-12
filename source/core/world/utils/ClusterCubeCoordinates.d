module core.world.utils.ClusterCubeCoordinates;

struct ClusterCubeCoordinates {
  uint x, y, z;

  invariant {
    assert(x < 256);
    assert(y < 256);
    assert(z < 256);
  }

  auto getClusterChunkCoordinates() {
    import core.world.utils.ClusterChunkCoordinates;
    return ClusterChunkCoordinates(x >> 4, y >> 4, z >> 4);
  }
}
