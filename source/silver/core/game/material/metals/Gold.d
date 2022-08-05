module core.game.material.Gold;

import core.game.material.Material;
import core.game.material.Metal;

class Gold : Metal {
  package this(Material[string] materials) {
    this.name = "GOLD";
    super();
  }
}
