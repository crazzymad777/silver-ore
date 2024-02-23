module silver.core.game.weapon.civil.Pick;

import silver.core.game.Weapon;

class Pick : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "pick";
    this.damageDice = 4;
    this.damageType = DamageType.PIERCING;
  }
}
