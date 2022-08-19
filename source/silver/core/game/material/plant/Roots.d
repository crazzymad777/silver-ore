module silver.core.game.material.plant.Roots;

import silver.core.game.material.Material;

class Roots : Material {
  package this(Material[string] materials) {
    this.name = "ROOTS";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
