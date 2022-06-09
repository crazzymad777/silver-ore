module core.game.Ore;

import core.game.material.Material;
import core.game.Item;

class Ore : Item {
  Material metal;
  this(Material metal) {
    assert(metal.isMetal());
    this.name = "unknown ore";
    if (metal.name == "GOLD") {
      this.name = "Native gold"; // Golden ore?
    } else if (metal.name == "SILVER") {
      this.name = "Acanthite";
    } else if (metal.name == "IRON") {
      this.name = "Hematite";
    } else if (metal.name == "TIN") {
      this.name = "Cassiterite";
    } else if (metal.name == "COPPER") {
      this.name = "Chalcocite";
    }
    this.metal = metal;
  }

  override string getName() {
    return name;
  }
}
