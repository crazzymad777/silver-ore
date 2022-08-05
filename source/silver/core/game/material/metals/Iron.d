module core.game.material.Iron;

import core.game.material.Material;
import core.game.material.Metal;

class Iron : Metal {
  package this(Material[string] materials) {
    this.name = "IRON";
    super();
  }
}
