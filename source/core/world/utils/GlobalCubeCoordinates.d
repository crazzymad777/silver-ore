module core.world.utils.GlobalCubeCoordinates;

struct GlobalCubeCoordinates {
  long x, y, z;
  static GlobalCubeCoordinates fromInternalCoordinates(ulong x, ulong y, ulong z) {
      return GlobalCubeCoordinates(x, y, z);
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
