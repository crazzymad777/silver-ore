module core.game.material.Air;

import core.game.material.Material;

class Air : Material {
  package this(Material[string] materials) {
    this.name = "AIR";
    super();
  }
}
