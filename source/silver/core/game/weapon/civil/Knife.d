module silver.core.game.weapon.civil.Knife;

import silver.core.game.Weapon;

class Knife : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "knife";
    this.damageDice = 4;
    this.damageType = DamageType.PIERCING;
  }
}
