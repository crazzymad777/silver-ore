module core.game.material.Silver;

import core.game.material.Material;
import core.game.material.Metal;

// extends Metal will crash :(
class Silver : Material {
  package this(Material[string] materials) {
    this.name = "SILVER";
    super(materials);
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
