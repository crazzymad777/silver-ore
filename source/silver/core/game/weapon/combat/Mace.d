module silver.core.game.weapon.combat.Mace;

import silver.core.game.Weapon;

class Mace : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "Mace";
    this.damageDice = 6;
    this.damageType = DamageType.BLUDGEONING;
  }
}
