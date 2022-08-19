module silver.core.game.material.plant.Branch;

import silver.core.game.material.Material;

class Branch : Material {
  package this(Material[string] materials) {
    this.name = "BRANCH";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
