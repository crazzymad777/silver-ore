module silver.core.game.weapon.combat.Shortsword;

import silver.core.game.Weapon;

class Shortsword : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "shortsword";
    this.damageDice = 6;
    this.damageType = DamageType.PIERCING;
  }
}
