module core.world.Cube;

import core.game.material.Material;
import core.game.Item;
import std.typecons;

class Cube {
  Item item = new Item();
  Material floor;
  Material wall;
  this(Material wall, Material floor) {
    this.floor = floor;
    this.wall = wall;
  }

  auto getItem() {
    return Nullable!Item(null);
    /* return Nullable!Item(item); */
  }

  auto display() {
    return 'g';
  }
}
