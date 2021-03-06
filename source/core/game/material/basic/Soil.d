module core.game.material.Soil;

import core.game.material.Material;

class Soil : Material {
  package this(Material[string] materials) {
    this.name = "SOIL";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
