module core.world.map.ClusterId;

struct ClusterId {
  private long x;
  private long y;
  /* {
    if (x < 0) {
      throw IllegalArgumentException("invalid x: $x")
    }

    if (y < 0) {
      throw IllegalArgumentException("invalid y: $y")
    }

    if (x > maxClusterId) {
      throw IllegalArgumentException("invalid x: $x")
    }

    if (y > maxClusterId) {
      throw IllegalArgumentException("invalid y: $y")
    }
  } */

  string toString() {
      // Show signed clusterId
      auto x = getSignedX();
      auto y = getSignedY();
      return "ClusterId(x=$x, y=$y)";
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

  static auto maxClusterId = 72057594037927935;

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
