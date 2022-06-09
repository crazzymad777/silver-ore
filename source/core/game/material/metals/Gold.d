module core.game.material.Gold;

import core.game.material.Material;

class Gold : Material {
  package this(Material[string] materials) {
    this.name = "GOLD";
    super(materials);
  }
}
