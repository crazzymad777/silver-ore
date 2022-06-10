module core.world.map.BiomeCell;

class BiomeCell {
  import core.world.map.ClusterId;
  import core.world.map.BiomeId;

  BiomeId id;
  private int size;
  private int seed;
  private ClusterId start;
  ClusterId biome_center;
  private BiomeCell[] cells;
  this(int seed, int size, ClusterId clusterId) {
    this(seed, size, clusterId.getUnsignedX()%size, clusterId.getUnsignedY()%size);
  }

  this(int seed, int size, int x, int y) {
    this(BiomeId(seed, size, x, y));
  }

  this(BiomeId id) {
    this.id = id;
    this.seed = id.seed;
    this.size = id.size;
    import core.world.utils.Seed: make, Random;
    import std.random: uniform;
    import std.format;
    start = signedClusterId(id.x*size, id.y*size);
    // Are clusterId.getSignedX() & clusterId.getSignedY() reproducible? Are start reproducible?
    // TODO: Need test
    auto cell_seed = make(format("%d:biomecells:%d:%d", id.seed, start.getSignedX(), start.getSignedX()));
    auto rnd = Random(cell_seed);
    biome_center = signedClusterId(start.x + uniform(0, id.size, rnd), start.y + uniform(0, id.size, rnd));
  }

  BiomeId getBiomeIdByClusterId(ClusterId clusterId) {
    // TODO: Neighbourhood biome cell MUST give same result
    // Not guaranteed yet
    import std.algorithm;
    import std.math;

    loadNeighbourhood();
    auto distances = cells.map!(cell => cell.biome_center).map!(other => pow(clusterId.x-other.x, 2)+pow(clusterId.y-other.y, 2));
    auto index = maxIndex(distances);
    return cells[index].id;
  }

  void loadNeighbourhood() {
    import std.conv: to;
    if (cells is null) {
      auto x = to!int(start.x/size);
      auto y = to!int(start.y/size);
      cells = [
          this,
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
