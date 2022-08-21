module silver.core.game.weapon.civil.Axe;

import silver.core.game.Weapon;

class Axe : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "axe";
    this.damageDice = 4;
    this.damageType = DamageType.SLASHING;
  }
}
