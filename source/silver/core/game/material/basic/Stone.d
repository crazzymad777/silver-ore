module silver.core.game.material.Stone;

import silver.core.game.material.Material;

class Stone : Material {
  package this(Material[string] materials) {
    this.name = "STONE";
    super();
  }

  override bool isSolid() {
    return true;
  }
}
