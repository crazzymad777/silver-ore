module core.game.material.Iron;

import core.game.material.Material;
import core.game.material.Metal;

// extends Metal will crash :(
class Iron : Material {
  package this(Material[string] materials) {
    this.name = "IRON";
    super(materials);
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
