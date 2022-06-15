module core.game.material.Metal;

import core.game.material.Material;

import core.game.material.Gold;
import core.game.material.Silver;
import core.game.material.Iron;
import core.game.material.Copper;
import core.game.material.Tin;

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
