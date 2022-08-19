module silver.core.game.material.Crust;

import silver.core.game.material.Material;

/// Earth's crust
class Crust : Material {
  package this(Material[string] materials) {
    this.name = "CRUST";
    super();
  }
}
