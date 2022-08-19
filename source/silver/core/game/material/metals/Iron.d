module silver.core.game.material.Iron;

import silver.core.game.material.Material;
import silver.core.game.material.Metal;

class Iron : Metal {
  package this(Material[string] materials) {
    this.name = "IRON";
    super();
  }
}
