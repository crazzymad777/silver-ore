module core.world.map.Biome;

import core.world.map.BiomeId;

class Biome {
  import core.world.map.BiomeCell;
  import core.world.map.Tile;

  private BiomeId id;
  private BiomeCell cell;
  TYPE type;
  enum TYPE {
    FLAT,
    DESERT,
    FOREST,
    TOWN_IN_FLAT,
    SEA,
  };

  this(BiomeId id) {
    this.id = id;
    import std.format, core.world.utils.Seed: make, Random;
    import std.random: uniform;
    auto seed = make(format("%d:biome:%d:%d",
                            id.seed,
                            id.x,
                            id.y
                            ));

    auto random = Random(seed);
    auto p = double(uniform!ulong(random))/ulong.max;

    if (p < 0.0625) {
      type = TYPE.SEA;
    } else if (p < 0.125) {
      type = TYPE.FOREST;
    } else if (p < 0.5 - 0.125) {
      type = TYPE.DESERT;
    } else if (p < 0.5 - 0.125 + 0.0625) {
      type = TYPE.TOWN_IN_FLAT;
    } else {
      type = TYPE.FLAT;
    }

    cell = new BiomeCell(id);
  }

  import core.world.map.ClusterId;
  Tile.TYPE getTileType(ClusterId clusterId) {
    if (type == TYPE.FLAT) {
      return Tile.TYPE.FLAT;
    } else if (type == TYPE.DESERT) {
      return Tile.TYPE.DESERT;
    } else if (type == TYPE.FOREST) {
      return Tile.TYPE.FOREST;
    } else if (type == TYPE.TOWN_IN_FLAT) {
      if (cell.biome_center == clusterId) {
        return Tile.TYPE.TOWN;
      }
      return Tile.TYPE.FLAT;
    } else if (type == TYPE.SEA) {
      return Tile.TYPE.SEA;
    }
    assert(false);
  }
}
