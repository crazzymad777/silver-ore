module core.world.Cube;

import core.game.material.Material;
import core.game.Item;
import core.game.Ore;
import std.typecons;

class Cube {
  Item item = null;
  Material floor;
  Material wall;
  Ore ore;
  this(Material wall, Material floor) {
    this.floor = floor;
    this.wall = wall;
  }

  void setOre(Ore ore) {
    this.ore = ore;
  }

  auto getItem() {
    if (ore !is null) {
      return ore;
    }
    return null;
    /* return Nullable!Item(item); */
  }
}
