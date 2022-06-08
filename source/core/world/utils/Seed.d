module core.world.utils.Seed;

ulong make(string str) {
  import std.digest.sha, core.stdc.string: memcpy;
  auto hash = sha256Of(str);
  ulong u = void;
  memcpy(&u, &hash, u.sizeof);
  return u;
}

auto Random(ulong seed) {
  /* import mir.random.engine.mersenne_twister; */
  import std.random;
  return Mt19937_64(seed);
}
