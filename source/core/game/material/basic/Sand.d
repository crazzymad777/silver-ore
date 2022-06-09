module core.game.material.Sand;

import core.game.material.Material;

class Sand : Material {
  package this(Material[string] materials) {
    this.name = "SAND";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
