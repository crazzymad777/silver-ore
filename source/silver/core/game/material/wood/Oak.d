module silver.core.game.material.Oak;

import silver.core.game.material.Material;
import silver.core.game.material.Wood;

class Oak : Wood {
  package this() {
    super();
  }

  package this(Material[string] materials) {
    this.name = "OAK";
    super();
  }
}
