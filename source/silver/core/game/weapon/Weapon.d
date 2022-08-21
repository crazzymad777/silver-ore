module silver.core.game.Weapon;

import silver.core.game.Item;

class Weapon : Item {
  import silver.core.game.DamageType;
  int damageDice = 1;
  DamageType damageType = damageType.BRUTE;
  this() {
    this.name = "weapon";
  }
}
