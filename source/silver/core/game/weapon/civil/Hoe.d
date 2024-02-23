module silver.core.game.weapon.civil.Hoe;

import silver.core.game.Weapon;

class Hoe : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "hoe";
    this.damageDice = 4;
    this.damageType = DamageType.SLASHING;
  }
}
