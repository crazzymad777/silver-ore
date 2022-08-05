module core.world.utils.WorldChunkCoordinates;

import core.world.utils.ClusterChunkCoordinates;
import core.world.map.ClusterId;

// relative obviously to world. x+1 next chunk on x-axis.
struct WorldChunkCoordinates {
  ulong x;
  ulong y;
  ulong z;

  ClusterId getClusterId() {
    return signedClusterId(long(x) >> 4, long(y) >> 4);
  }

  /// test getClusterId
  private unittest {
    import std.random: Random, unpredictableSeed, uniform;
    import core.world.utils.GlobalCubeCoordinates;
    auto rnd = Random(unpredictableSeed);
    auto x = uniform!int(rnd);
    auto y = uniform!int(rnd);
    auto z = uniform!int(rnd);

    auto global = GlobalCubeCoordinates(x, y, z);

    auto ux = ulong(x)/16u;
    auto uy = ulong(y)/16u;

    auto coors = global.getChunkCoordinates();

    auto actual = signedClusterId(long(ux)/16, long(uy)/16);
    auto expected = coors.getClusterId();
    assert(expected == actual);
  }

  auto getClusterChunkCoordinates()  {
    import std.math;
    return ClusterChunkCoordinates((x & 0b1111), (y & 0b1111), (z & 0b1111));
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
