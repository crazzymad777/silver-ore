module silver.core.game.Weapon;

import silver.core.game.Item;

class Weapon : Item {
  protected int damageDice = 1;
  this() {
    this.name = "weapon";
  }
}
