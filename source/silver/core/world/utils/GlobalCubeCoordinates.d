module core.world.utils.GlobalCubeCoordinates;

import core.world.utils.WorldChunkCoordinates;

struct GlobalCubeCoordinates {
  long x, y, z;
  static auto fromInternalCoordinates(ulong x, ulong y, ulong z) {
      return GlobalCubeCoordinates(x, y, z);
  }

  auto getChunkCoordinates() {
    return WorldChunkCoordinates(ulong(x) >> 4, ulong(y) >> 4, ulong(z) >> 4);
  }
}

/// test fromInternalCoordinates
private unittest {
  import std.random: Random, unpredictableSeed, uniform;
  auto rnd = Random(unpredictableSeed);
  ulong x = uniform!int(rnd);
  ulong y = uniform!int(rnd);
  ulong z = uniform!int(rnd);

  auto actual = GlobalCubeCoordinates.fromInternalCoordinates((-1*x), (-1*y), (-1*z));
  assert(GlobalCubeCoordinates(-1*x, -1*y, -1*z) == actual);
}
