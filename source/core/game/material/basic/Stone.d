module core.game.material.Stone;

import core.game.material.Material;

class Stone : Material {
  package this(Material[string] materials) {
    this.name = "STONE";
    super(materials);
  }

  override bool isSolid() {
    return true;
  }
}
