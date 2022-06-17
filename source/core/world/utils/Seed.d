module core.world.utils.Seed;

/// hash function
export ulong make(string str) {
  import std.digest.sha, core.stdc.string: memcpy;
  auto hash = sha256Of(str);
  ulong u = void;
  memcpy(&u, &hash, u.sizeof);
  return u;
}

/// test make
private unittest {
  auto expected = 16055602073433090460u;
  auto str = "0:silver-ore:make:test";
  auto actual = make(str);
  assert(actual == expected);
}

/// get default (for silver ore) random generator
export auto Random(ulong seed) {
  import std.random;
  return Mt19937_64(seed);
}

/// test Random by taking ulong
private unittest {
  import std.random: uniform;
  auto expected = 9663517775653789231u;
  auto seed = 16055602073433090460u;
  auto random = Random(seed);
  auto actual = uniform!ulong(random);
  assert(actual == expected);
}

/// test Random by taking double
private unittest {
  import std.random: uniform;
  auto expected = 5.23860348310806411831208606599830090999603271484375e-01;
  auto seed = 16055602073433090460u;
  auto random = Random(seed);
  auto actual = double(uniform!ulong(random))/ulong.max;
  assert(actual == expected);
}
