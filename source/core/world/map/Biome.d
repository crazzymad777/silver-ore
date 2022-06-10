module core.world.map.Biome;

import core.world.map.BiomeId;

class Biome {
  import core.world.map.Tile;

  private BiomeId id;
  Tile.TYPE type;
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
      type = Tile.TYPE.SEA;
    } else if (p < 0.125) {
      type = Tile.TYPE.FOREST;
    } else if (p < 0.5 - 0.125) {
      type = Tile.TYPE.DESERT;
    } else {
      type = Tile.TYPE.FLAT;
    }
  }
}
