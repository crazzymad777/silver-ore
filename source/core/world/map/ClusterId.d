module core.world.map.ClusterId;

export auto signedClusterId(long x, long y) {
  return ClusterId.signedClusterId(x, y);
}

struct ClusterId {
  const static auto maxClusterId = 72057594037927935;
  long x;
  long y;

  invariant {
    /* assert(ulong(x) <= maxClusterId);
    assert(ulong(y) <= maxClusterId); */
  }

  size_t toHash() const @safe pure nothrow
  {
    return x + y*maxClusterId;
  }

  bool opEquals(ref const ClusterId other) const @safe pure nothrow
  {
    return other.x == x && other.y == y;
  }

  string toString() {
      // Show signed clusterId
      import std.format;
      auto x = getSignedX();
      auto y = getSignedY();
      return format("ClusterId(x=%d, y=%d)", x, y);
  }

  long getSignedX() {
      auto half = maxClusterId / 2;
      return (x < half) ? this.x : (-this.x+half*2)*-1-2;
  }

  long getSignedY() {
      auto half = maxClusterId / 2;
      return (y < half) ? this.y : (-this.y+half*2)*-1-2;
  }

  long getUnsignedX() {
      return x;
  }

  long getUnsignedY() {
      return y;
  }

  static auto signedClusterId(long x, long y) {
    ulong unsignedX = void, unsignedY = void;
    if (x < 0) {
      unsignedX = maxClusterId + x + 1;
    } else if (x > maxClusterId) {
      unsignedX = x - maxClusterId - 1;
    } else {
      unsignedX = x;
    }

    if (y < 0) {
      unsignedY = maxClusterId + y + 1;
    } else if (y > maxClusterId) {
      unsignedY = y - maxClusterId - 1;
    } else {
      unsignedY = y;
    }
    return ClusterId(unsignedX, unsignedY);
  }

  auto getNeighbourhood() {
    return [
        signedClusterId(x, y-1),
        signedClusterId(x+1, y-1),
        signedClusterId(x+1, y),
        signedClusterId(x+1, y+1),
        signedClusterId(x, y+1),
        signedClusterId(x-1, y+1),
        signedClusterId(x-1, y),
        signedClusterId(x-1, y-1)
    ];
  }
}
