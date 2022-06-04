module core.world.Cube;

import core.game;
import std.typecons;

class Cube {
  Item item = new Item();

  Nullable!Item getItem() {
    return Nullable!Item(item);
  }

  char display() {
    return 'g';
  }
}
