module silver.core.game.weapon.civil.Shovel;

import silver.core.game.Weapon;

class Shovel : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "Shovel";
    this.damageDice = 4;
    this.damageType = DamageType.SLASHING;
  }
}
