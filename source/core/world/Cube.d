module core.world.Cube;

import core.game;
import std.typecons;

class Cube {
  Item item = new Item();
  string floor = "grass";
  string wall = "grass";

  auto getItem() {
    return Nullable!Item(null);
    /* return Nullable!Item(item); */
  }

  auto display() {
    return 'g';
  }
}
