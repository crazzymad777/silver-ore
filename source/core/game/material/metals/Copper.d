module core.game.material.Copper;

import core.game.material.Material;

class Copper : Material {
  package this(Material[string] materials) {
    this.name = "COPPER";
    super(materials);
  }
}
