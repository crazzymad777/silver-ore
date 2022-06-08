module core.world.utils.Seed;

ulong make(string str) {
    return 0;
}

auto Random(ulong seed) {
  /* import mir.random.engine.mersenne_twister; */
  import std.random;
  return Mt19937_64(seed);
}
