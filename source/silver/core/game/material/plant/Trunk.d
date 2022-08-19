module silver.core.game.material.plant.Trunk;

import silver.core.game.material.Material;

class Trunk : Material {
  package this(Material[string] materials) {
    this.name = "TRUNK";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
