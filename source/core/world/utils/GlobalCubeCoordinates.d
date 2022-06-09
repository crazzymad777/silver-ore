module core.world.utils.GlobalCubeCoordinates;

import core.world.utils.WorldChunkCoordinates;

struct GlobalCubeCoordinates {
  long x, y, z;
  static GlobalCubeCoordinates fromInternalCoordinates(ulong x, ulong y, ulong z) {
      return GlobalCubeCoordinates(x, y, z);
  }

  WorldChunkCoordinates getChunkCoordinates() {
    return WorldChunkCoordinates(ulong(x) >> 4, ulong(y) >> 4, ulong(z) >> 4);
  }
}

/// test fromInternalCoordinates
private unittest {
  ulong x = 12;
  ulong y = -12;
  ulong z = 13;

  auto actual = GlobalCubeCoordinates.fromInternalCoordinates((-1*x), (-1*y), (-1*z));
  assert(GlobalCubeCoordinates(-1*x, -1*y, -1*z) == actual);
}
