module silver.core.game.material.Tin;

import silver.core.game.material.Material;
import silver.core.game.material.Metal;

class Tin : Metal {
  package this(Material[string] materials) {
    this.name = "TIN";
    super();
  }
}
