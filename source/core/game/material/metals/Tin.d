module core.game.material.Tin;

import core.game.material.Material;
import core.game.material.Metal;

// extends Metal will crash :(
class Tin : Material {
  package this(Material[string] materials) {
    this.name = "TIN";
    super(materials);
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
