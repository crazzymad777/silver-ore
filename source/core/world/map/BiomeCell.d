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
    this(seed, size, clusterId.getSignedX()/size, clusterId.getSignedY()/size);
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
    import std.format, std.math.trigonometry, std.math.constants;
    import std.conv;
    start = signedClusterId(id.x*size, id.y*size);
    // Are clusterId.getSignedX() & clusterId.getSignedY() reproducible? Are start reproducible?
    // TODO: Need test
    auto cell_seed = make(format("%d:biomecells:%d:%d", id.seed, id.x, id.y));
    auto rnd = Random(cell_seed);
    auto x = uniform(0, size, rnd);
    auto y = uniform(0, size, rnd);
    /* auto r = uniform(0, size/2, rnd); */
    /* auto angle = uniform(0.0, 2*PI, rnd); */
    /* auto x = to!long(cos(angle)*r + size/2); */
    /* auto y = to!long(sin(angle)*r + size/2); */
    biome_center = signedClusterId(start.getSignedX() + x, start.getSignedY() + y);
    /* biome_center = ClusterId(start.x + size/2, start.y + size/2); */
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
      pow(pow(clusterId.getSignedX()-other.getSignedX(), power) + pow(clusterId.getSignedY()-other.getSignedY(), power), 1.0/power)
    );
    /* auto array = distances.map!(x => pow(x[0] + x[1], 1.0/power)).maxIndex(); */
    auto index = distances.minIndex();
    auto ownDistance = pow(pow(clusterId.getSignedX()-biome_center.getSignedX(), power) + pow(clusterId.getSignedY()-biome_center.getSignedY(), power), 1.0/power);

    if (ownDistance == distances[index]) {
      if (id.x%2 == 0 && cells[index].id.x%2 == 1) {
        return this.id;
      } else if (id.y%2 == 0 && cells[index].id.y%2 == 1) {
        return this.id;
      }
      if (id.x > cells[index].id.x) {
        return this.id;
      }
      if (id.y > cells[index].id.y) {
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
      auto x = to!long(start.getSignedX()/size);
      auto y = to!long(start.getSignedY()/size);
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
