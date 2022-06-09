module core.game.material.Void;

import core.game.material.Material;

class Void : Material {
  package this(Material[string] materials) {
    this.name = "VOID";
    super(materials);
  }
}
