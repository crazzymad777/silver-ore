module silver.core.game.material.plant.Foliage;

import silver.core.game.material.Material;

class Foliage : Material {
  package this(Material[string] materials) {
    this.name = "Foliage";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
