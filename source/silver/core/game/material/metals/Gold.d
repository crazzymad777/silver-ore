module silver.core.game.material.Gold;

import silver.core.game.material.Material;
import silver.core.game.material.Metal;

class Gold : Metal {
  package this(Material[string] materials) {
    this.name = "GOLD";
    super();
  }
}
