module core.world.Map;

import std.datetime.systime;

class Map {
  import core.world.map.ClusterId;
  import core.world.map.BiomeId;
  import core.world.map.Biome;
  import core.world.map.Tile;

  private Tile[ClusterId] tiles;
  private Biome[BiomeId] biomes;
  ClusterId defaultClusterId;
  private long seed;

  this(long seed = Clock.currTime().toUnixTime()) {
    this.seed = seed;
    defaultClusterId = signedClusterId(0, 0);

    /* Tile tile; */
    /* long i, x, y; */
    /* int k = 16;
    while (true) {
      auto clusterId = signedClusterId(x+i*k, y+i*k);
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
    } */
  }

  void clearBiomes() {
    biomes.clear();
  }

  BiomeId getBiomeId(ClusterId clusterId) {
    import core.world.map.BiomeCell;
    int size = 8;
    BiomeCell cell = new BiomeCell(seed, size, clusterId);
    return cell.getBiomeIdByClusterId(clusterId);
  }

  Tile.TYPE getTileType(ClusterId clusterId) {
    return getTile(clusterId).type;
  }

  Tile getTile(ClusterId clusterId) {
    // Map -> Biome -> Tile ?
    import core.world.map.BiomeCell;

    auto tile_ptr = (clusterId in tiles);
    if (tile_ptr !is null) {
      return *tile_ptr;
    }

    int size = 8;
    BiomeCell cell = new BiomeCell(seed, size, clusterId);
    BiomeId id = cell.getBiomeIdByClusterId(clusterId);

    Tile.TYPE type = Tile.TYPE.FLAT;
    auto biome_ptr = (id in biomes);
    if (biome_ptr is null) {
      biomes[id] = new Biome(id);
      type = biomes[id].type;
    } else {
      type = biome_ptr.type;
    }



    /* import std.format, core.world.utils.Seed: make, Random;
    import std.random: uniform;
    auto seed = make(format("%d:map_tile:%d:%d",
                            this.seed,
                            clusterId.getSignedX(),
                            clusterId.getSignedY()
                            ));

    auto random = Random(seed);
    auto p = double(uniform!ulong(random))/ulong.max;
    Tile.TYPE type = void; */
    /* if (p < 0.00625) {
      type = Tile.TYPE.TOWN;
    } else if (p < 0.125) {
      type = Tile.TYPE.SEA;
    } else if (p < 0.25) {
      type = Tile.TYPE.FOREST;
    } else if (p < 0.5) {
      type = Tile.TYPE.DESERT;
    } else {
      type = Tile.TYPE.FLAT;
    } */

    return tiles[clusterId] = Tile(clusterId, type);
  }

  ulong biomesLoaded() {
    return biomes.length;
  }
}
