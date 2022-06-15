module core.game.material.Tin;

import core.game.material.Material;
import core.game.material.Metal;

class Tin : Metal {
  package this(Material[string] materials) {
    this.name = "TIN";
    super();
  }
}
