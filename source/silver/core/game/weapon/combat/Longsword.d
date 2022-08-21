module silver.core.game.weapon.combat.Longsword;

import silver.core.game.Weapon;

class Longsword : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "longsword";
    this.damageDice = 8;
    this.damageType = DamageType.SLASHING;
  }
}
