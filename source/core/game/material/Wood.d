module core.game.material.Wood;

import core.game.material.Material;

class Wood : Material {
  package this(Material[string] materials) {
    this.name = "WOOD";
    super(materials);
  }
}
