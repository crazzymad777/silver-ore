module silver.core.game.weapon.combat.Warhammer;

import silver.core.game.Weapon;

class Warhammer : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "warhammer";
    this.damageDice = 8;
    this.damageType = DamageType.BLUDGEONING;
  }
}
