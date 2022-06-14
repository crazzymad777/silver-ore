module core.world.map.ClusterId;

export auto signedClusterId(long x, long y) {
  return ClusterId.signedClusterId(x, y);
}

struct ClusterId {
  const static auto maxClusterId = 72057594037927935;
  private long x;
  private long y;

  void setX(long x) {
    this.x = signed(x);
  }

  void setY(long y) {
    this.y = signed(y);
  }

  invariant {
    assert(ulong(x) <= maxClusterId);
    assert(ulong(y) <= maxClusterId);
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
      auto x = this.x;
      return (x < half) ? x : (-x+half*2)*-1-2;
  }

  long getSignedY() {
      auto half = maxClusterId / 2;
      auto y = this.y;
      return (y < half) ? y : (-y+half*2)*-1-2;
  }

  long getUnsignedX() {
      return x;
  }

  long getUnsignedY() {
      return y;
  }

  static auto signed(long value) {
    ulong unsigned = void;
    if (value < 0) {
      unsigned = maxClusterId + value + 1;
    } else if (value > maxClusterId) {
      unsigned = value - maxClusterId - 1;
    } else {
      unsigned = value;
    }
    return unsigned;
  }

  static auto signedClusterId(long x, long y) {
    ulong unsignedX = signed(x), unsignedY = signed(y);
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
