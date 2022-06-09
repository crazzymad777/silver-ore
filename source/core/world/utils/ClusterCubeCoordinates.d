module core.world.utils.ClusterCubeCoordinates;

struct ClusterCubeCoordinates {
  uint x, y, z;

  auto getClusterChunkCoordinates() {
    import core.world.utils.ClusterChunkCoordinates;
    return ClusterChunkCoordinates(x >> 4, y >> 4, z >> 4);
  }
}
