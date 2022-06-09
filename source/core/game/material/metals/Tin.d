module core.game.material.Tin;

import core.game.material.Material;

class Tin : Material {
  package this(Material[string] materials) {
    this.name = "TIN";
    super(materials);
  }
}
