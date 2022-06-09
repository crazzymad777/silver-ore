module core.game.material.Iron;

import core.game.material.Material;

class Iron : Material {
  package this(Material[string] materials) {
    this.name = "IRON";
    super(materials);
  }
}
