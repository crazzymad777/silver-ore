module silver.core.game.material.Sand;

import silver.core.game.material.Material;

class Sand : Material {
  package this(Material[string] materials) {
    this.name = "SAND";
    super();
  }

  override bool isSolid() {
    return true;
  }
}
