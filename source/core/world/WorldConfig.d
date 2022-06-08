module core.world.WorldConfig;

import std.datetime.systime;

class WorldConfig {
  long seed;
  string generatorName = "flat";
  bool enableNegativeCoordinates = true;

  this(long seed = Clock.currTime().toUnixTime(), string generatorName = "flat", bool enableNegativeCoordinates = true) {
    this.seed = seed;
    this.generatorName = generatorName;
    this.enableNegativeCoordinates = enableNegativeCoordinates;
  }
}
