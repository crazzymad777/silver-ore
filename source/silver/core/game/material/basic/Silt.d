module core.game.material.Silt;

import core.game.material.Material;

class Silt : Material {
  package this(Material[string] materials) {
    this.name = "SILT";
    super();
  }

  override bool isSolid() {
    return true;
  }
}
