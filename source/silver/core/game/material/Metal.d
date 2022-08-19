module silver.core.game.material.Metal;

import silver.core.game.material.Material;

import silver.core.game.material.Gold;
import silver.core.game.material.Silver;
import silver.core.game.material.Iron;
import silver.core.game.material.Copper;
import silver.core.game.material.Tin;

class Metal : Material {
  package this() {
    super();
  }

  package this(Material[string] materials) {
    import std.meta;
    foreach(y; AliasSeq!(Gold, Silver, Iron, Copper, Tin)) {
      materials[y.stringof] = new y(materials);
    }
    this.name = "METAL";
    super();
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
