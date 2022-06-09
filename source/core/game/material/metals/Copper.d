module core.game.material.Copper;

import core.game.material.Material;
import core.game.material.Metal;

// extends Metal will crash :(
class Copper : Material {
  package this(Material[string] materials) {
    this.name = "COPPER";
    super(materials);
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
