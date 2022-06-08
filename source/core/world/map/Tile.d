module core.world.map.Tile;

import core.world.map.ClusterId;

struct Tile {
  private ClusterId clusterId;
  private TYPE type;

  enum TYPE {
    TOWN,
    FLAT,
    SEA,
  }

  static bool isSea(TYPE type) {
    if (type == TYPE.SEA) {
      return true;
    }
    return false;
  }
}
