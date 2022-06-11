module core.world.map.BiomeId;

struct BiomeId {
  long seed;
  int size;
  long x;
  long y;
  int ver = 1;

  size_t toHash() const @safe pure nothrow
  {
    auto hash = 7L;
    hash = 31 * hash + x;
    hash = 31 * hash + y;
    hash = 31 * hash + seed;
    hash = 31 * hash + size;
    hash = 31 * hash + ver;
    return hash;
  }

  bool opEquals(ref const BiomeId other) const @safe pure nothrow
  {
    return other.x == x && other.y == y && other.seed == seed && other.size == size && other.ver == ver;
  }
}
