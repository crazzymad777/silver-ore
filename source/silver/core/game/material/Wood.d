module silver.core.game.material.Wood;

import silver.core.game.material.Material;
import silver.core.game.material.Oak;

class Wood : Material {
  package this() {
    super();
  }

  package this(Material[string] materials) {
    import std.meta;
    foreach(y; AliasSeq!(Oak)) {
      materials[y.stringof] = new y(materials);
    }
    this.name = "WOOD";
    super();
  }

  override bool isSolid() {
    return true;
  }
}
