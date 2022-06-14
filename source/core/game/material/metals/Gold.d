module core.game.material.Gold;

import core.game.material.Material;
import core.game.material.Metal;

// extends Metal will crash :(
class Gold : Material {
  package this(Material[string] materials) {
    this.name = "GOLD";
    super(materials);
  }

  override bool isMetal() {
    return true;
  }

  override bool isSolid() {
    return true;
  }
}
