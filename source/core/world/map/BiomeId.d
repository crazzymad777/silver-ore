module core.world.map.BiomeId;

struct BiomeId {
  int seed;
  int size;
  int x;
  int y;
  int ver = 1;

  size_t toHash() const @safe pure nothrow
  {
    return x + y + seed + size + ver;
  }

  bool opEquals(ref const BiomeId other) const @safe pure nothrow
  {
    return other.x == x && other.y == y && other.seed == seed && other.size == size && other.ver == ver;
  }
}
