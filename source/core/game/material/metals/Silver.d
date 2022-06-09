module core.game.material.Silver;

import core.game.material.Material;

class Silver : Material {
  package this(Material[string] materials) {
    this.name = "SILVER";
    super(materials);
  }
}
