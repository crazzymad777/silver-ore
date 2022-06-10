module core.world.map.BiomeCell;

class BiomeCell {
  import core.world.map.ClusterId;
  import core.world.map.BiomeId;

  BiomeId id;
  private int size;
  private long seed;
  private ClusterId start;
  ClusterId biome_center;
  private BiomeCell[] cells;
  this(long seed, int size, ClusterId clusterId) {
    /* import std.conv: to; */
    this(seed, size, clusterId.x/size, clusterId.y/size);
  }

  this(long seed, int size, long x, long y) {
    this(BiomeId(seed, size, x, y));
  }

  this(BiomeId id) {
    this.id = id;
    this.seed = id.seed;
    this.size = id.size;
    import core.world.utils.Seed: make, Random;
    import std.random: uniform, dice;
    import std.format;
    start = signedClusterId(id.x*size, id.y*size);
    // Are clusterId.getSignedX() & clusterId.getSignedY() reproducible? Are start reproducible?
    // TODO: Need test
    auto cell_seed = make(format("%d:biomecells:%d:%d", id.seed, id.x, id.y));
    auto rnd = Random(cell_seed);
    auto x = uniform(0, size, rnd);
    auto y = uniform(0, size, rnd);
    /* auto x = dice(rnd, 1, 2, 3, 8, 8, 3, 2, 1); */
    /* auto y = dice(rnd, 1, 2, 3, 8, 8, 3, 2, 1); */
    /* biome_center = signedClusterId(start.x + x, start.y + y); */
    biome_center = ClusterId(start.x + size/2, start.y + size/2);
  }

  BiomeId getBiomeIdByClusterId(ClusterId clusterId) {
    import std.typecons: tuple;
    // TODO: Neighbourhood biome cell MUST give same result
    // Not guaranteed yet
    import std.algorithm;
    import std.math;

    loadNeighbourhood();
    int power = 2;
    auto distances = cells.map!(cell => cell.biome_center).map!(other =>
      /* tuple(pow(clusterId.x-other.x, power), pow(clusterId.y-other.y, power)) */
      pow(pow(clusterId.x-other.x, power) + pow(clusterId.y-other.y, power), 1.0/power)
    );
    /* auto array = distances.map!(x => pow(x[0] + x[1], 1.0/power)).maxIndex(); */
    auto index = distances.minIndex();
    auto ownDistance = pow(pow(clusterId.x-biome_center.x, power) + pow(clusterId.y-biome_center.y, power), 1.0/power);

    if (ownDistance == distances[index]) {
      if (id.x%2 == 0 && cells[index].id.x%2 == 1) {
        return this.id;
      } else if (id.y%2 == 0 && cells[index].id.y%2 == 1) {
        return this.id;
      }
      if (id.x > this.id.x) {
        return this.id;
      }
      if (id.y > this.id.y) {
        return this.id;
      }
    }

    if (ownDistance < distances[index]) {
      return this.id;
    }

    return cells[index].id;
  }

  void loadNeighbourhood() {
    import std.conv: to;
    if (cells is null) {
      auto x = to!long(start.x/size);
      auto y = to!long(start.y/size);
      cells = [
          new BiomeCell(seed, size, x, y-1),
          new BiomeCell(seed, size, x+1, y-1),
          new BiomeCell(seed, size, x+1, y),
          new BiomeCell(seed, size, x+1, y+1),
          new BiomeCell(seed, size, x, y+1),
          new BiomeCell(seed, size, x-1, y+1),
          new BiomeCell(seed, size, x-1, y),
          new BiomeCell(seed, size, x-1, y-1)
      ];
    }
  }
}
