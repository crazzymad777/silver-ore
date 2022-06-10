module core.world.map.BiomeId;

struct BiomeId {
  long seed;
  int size;
  long x;
  long y;
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
