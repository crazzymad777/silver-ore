module core.game.material.Silt;

import core.game.material.Material;

class Silt : Material {
  package this(Material[string] materials) {
    this.name = "SILT";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
