module silver.core.game.material.Mantle;

import silver.core.game.material.Material;

/// Earth's mantle
class Mantle : Material {
  package this(Material[string] materials) {
    this.name = "MANTLE";
    super();
  }
}
