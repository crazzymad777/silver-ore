module core.world.Cube;

import core.game.material.Material;
import core.game.Furniture;
import core.game.Item;
import core.game.Ore;
import std.typecons;

class Cube {
  Item item = null;
  Material floor;
  Material wall;
  Ore ore;
  Furniture furniture;
  this(Material wall, Material floor) {
    this.floor = floor;
    this.wall = wall;
  }

  void setOre(Ore ore) {
    this.ore = ore;
  }

  void setFurniture(Furniture furniture) {
    this.furniture = furniture;
  }

  Item getItem() {
    if (furniture !is null) {
      return furniture;
    }

    if (ore !is null) {
      return ore;
    }

    return null;
  }
}
