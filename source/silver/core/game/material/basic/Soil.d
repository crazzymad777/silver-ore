module silver.core.game.material.Soil;

import silver.core.game.material.Material;

class Soil : Material {
  package this(Material[string] materials) {
    this.name = "SOIL";
    super();
  }

  override bool isSolid() {
    return true;
  }
}
