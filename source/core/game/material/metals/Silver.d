module core.game.material.Silver;

import core.game.material.Material;
import core.game.material.Metal;

class Silver : Metal {
  package this(Material[string] materials) {
    this.name = "SILVER";
    super();
  }
}
