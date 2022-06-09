module core.world.utils.ClusterChunkCoordinates;

struct ClusterChunkCoordinates {
  uint x;
  uint y;
  uint z;
  /* init {
    if (x >= 16u) {
      throw IllegalArgumentException("invalid x: $x")
    }
    if (y >= 16u) {
      throw IllegalArgumentException("invalid y: $y")
    }
    if (z >= 16u) {
      throw IllegalArgumentException("invalid z: $z")
    }
  } */

  uint getChunkId() {
    return x+y*16u+z*16u*16u;
  }

  /// test getChunkId
  private unittest {
    import std.random: Random, unpredictableSeed, uniform;
    auto rnd = Random(unpredictableSeed);
    for (int i = 0; i < 100; i++) {
      auto x = uniform!uint(rnd)%16u;
      auto y = uniform!uint(rnd)%16u;
      auto z = uniform!uint(rnd)%16u;
      auto expected = x+y*16u+z*16u*16u;
      auto actual = ClusterChunkCoordinates(x, y, z).getChunkId();
      assert(expected == actual);
    }
  }
}
