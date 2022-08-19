module silver.core.game.material.Silver;

import silver.core.game.material.Material;
import silver.core.game.material.Metal;

class Silver : Metal {
  package this(Material[string] materials) {
    this.name = "SILVER";
    super();
  }
}
