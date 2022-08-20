module silver.core.game.material.Dispenser;

import silver.core.game.material.Material;
import silver.core.game.material.Metal;
import silver.core.game.material.Grass;
import silver.core.game.material.Stone;
import silver.core.game.material.Wood;
import silver.core.game.material.Soil;
import silver.core.game.material.Void;
import silver.core.game.material.Air;
import silver.core.game.material.Water;
import silver.core.game.material.Silt;
import silver.core.game.material.Sand;
import silver.core.game.material.Mantle;

class Dispenser {
  static private Material[string] materials;
  private this() {
    import std.meta;
    static foreach(y; AliasSeq!(Material, Wood, Grass, Metal, Soil, Air, Void, Stone, Sand, Silt, Water, Mantle)) {
      materials[y.stringof] = new y(materials);
    }
  }

  Material getMaterial(string name = "Void") {
    synchronized {
      if (name in materials) {
        return materials[name];
      }
      return materials["Void"];
    }
  }

  /*
    Low-Lock Singleton Pattern
    Singleton source: https://wiki.dlang.org/Low-Lock_Singleton_Pattern
    From David Simcha's D-Specific Design Patterns talk at DConf 2013.
    D-lang wiki footer: Content is available under GNU Free Documentation License 1.3 or later unless otherwise noted.
  */
  // Cache instantiation flag in thread-local bool
  // Thread local
  private static bool instantiated_;

  // Thread global
  private __gshared Dispenser instance_;

  static Dispenser get() {
    if (!instantiated_) {
      synchronized(Dispenser.classinfo)
      {
        if (!instance_)
        {
          instance_ = new Dispenser();
        }

        instantiated_ = true;
      }
    }
    return instance_;
  }
}
