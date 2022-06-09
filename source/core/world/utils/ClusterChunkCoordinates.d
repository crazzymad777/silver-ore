module core.world.utils.ClusterChunkCoordinates;

struct ClusterChunkCoordinates {
  uint x;
  uint y;
  uint z;

  invariant
  {
    assert(x < 16);
    assert(y < 16);
    assert(z < 16);
  }

  ushort getChunkId() {
    import std.conv: to;
    return to!ushort(x+y*16u+z*16u*16u);
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
