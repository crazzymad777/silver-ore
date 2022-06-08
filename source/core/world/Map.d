module core.world.Map;

import std.datetime.systime;

class Map {
  import core.world.map.Tile;
  import core.world.map.ClusterId;

  private Tile[ClusterId] tiles;
  ClusterId defaultClusterId;
  private long seed;

  this(long seed = Clock.currTime().toUnixTime()) {
    this.seed = seed;
    Tile tile;
    long i, x, y;

    int k = 16;
    while (true) {
      auto clusterId = ClusterId(x+i*k, y+i*k);
      tile = getTile(clusterId);

      if (tile.type == Tile.TYPE.TOWN) {
        defaultClusterId = clusterId;
        break;
      }

      x++;
      if (x >= i*k) {
        y++;
        x = 0;
        if (y >= i*k) {
          y = 0;
          i++;
        }
      }
    }
  }

  Tile.TYPE getTileType(ClusterId clusterId) {
    return getTile(clusterId).type;
  }

  Tile getTile(ClusterId clusterId) {
    auto tile_ptr = (clusterId in tiles);
    if (tile_ptr !is null) {
      return *tile_ptr;
    }

    import std.format, core.world.utils.Seed: make, Random;
    import std.random: uniform;
    auto seed = make(format("%d:map_tile:%d:%d",
                            this.seed,
                            clusterId.getSignedX(),
                            clusterId.getSignedY()
                            ));

    auto random = Random(seed);
    auto p = uniform(0.0f, 1.0f, random);
    Tile.TYPE type = void;
    if (p < 0.05) {
      type = Tile.TYPE.TOWN;
    } else if (p < 0.25) {
      type = Tile.TYPE.SEA;
    } else {
      type = Tile.TYPE.FLAT;
    }

    return tiles[clusterId] = Tile(clusterId, type);
  }
}
