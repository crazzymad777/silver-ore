module core.world.utils.WorldChunkCoordinates;

import core.world.utils.ClusterChunkCoordinates;
import core.world.map.ClusterId;

// relative obviously to world. x+1 next chunk on x-axis.
struct WorldChunkCoordinates {
  ulong x;
  ulong y;
  ulong z;

  ClusterId getClusterId() {
    return ClusterId(long(x) >> 4, long(y) >> 4);
  }

  ClusterChunkCoordinates getClusterChunkCoordinates()  {
    return ClusterChunkCoordinates((x%16u), (y%16u), (z%16u));
  }

  /// test getClusterChunkCoordinates
  private unittest {
    import std.random: Random, unpredictableSeed, uniform;
    auto rnd = Random(unpredictableSeed);
    for (int i = 0; i < 100; i++) {
      int x = uniform!uint(rnd);
      int y = uniform!uint(rnd);
      int z = uniform!uint(rnd);
      auto expected = ClusterChunkCoordinates(x%16u, y%16u, z%16u);
      auto actual = WorldChunkCoordinates(ulong(x), ulong(y), ulong(z)).getClusterChunkCoordinates();
      assert(expected == actual);
    }
  }
}
