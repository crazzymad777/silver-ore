module core.game.material.Dispenser;

import core.game.material.Material;
import core.game.material.Metal;
import core.game.material.Grass;
import core.game.material.Stone;
import core.game.material.Wood;
import core.game.material.Soil;
import core.game.material.Void;
import core.game.material.Air;
import core.game.material.Water;
import core.game.material.Silt;
import core.game.material.Sand;
import core.game.material.Crust;

/*
  Low-Lock Singleton Pattern
  Singleton source: https://wiki.dlang.org/Low-Lock_Singleton_Pattern
  From David Simcha's D-Specific Design Patterns talk at DConf 2013.
  D-lang wiki footer: Content is available under GNU Free Documentation License 1.3 or later unless otherwise noted.
*/

class Dispenser {
  static private Material[string] materials;
  private this() {
    static const auto x = ["Material", "Wood", "Grass", "Metal", "Soil", "Air", "Void", "Stone", "Sand", "Silt", "Water", "Crust"];
    static foreach(y; x) {
      materials[y] = new mixin(y)(materials);
    }
  }

  Material getMaterial(string name = "Material") {
    synchronized {
      if (name in materials) {
        return materials[name];
      }
      return materials["Void"];
    }
  }

  /* Singleton */
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
