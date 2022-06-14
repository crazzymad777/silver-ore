module core.game.material.Metal;

import core.game.material.Material;

import core.game.material.Gold;
import core.game.material.Silver;
import core.game.material.Iron;
import core.game.material.Copper;
import core.game.material.Tin;

class Metal : Material {
  package this(Material[string] materials) {
    static const auto x = ["Gold", "Silver", "Iron", "Copper", "Tin"];
    static foreach(y; x) {
      materials[y] = new mixin(y)(materials);
    }
    this.name = "METAL";
    super(materials);
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
