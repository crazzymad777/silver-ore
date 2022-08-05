module core.game.material.Copper;

import core.game.material.Material;
import core.game.material.Metal;

class Copper : Metal {
  package this(Material[string] materials) {
    this.name = "COPPER";
    super();
  }
}
