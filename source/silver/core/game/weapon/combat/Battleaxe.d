module silver.core.game.weapon.combat.Battleaxe;

import silver.core.game.Weapon;

class Battleaxe : Weapon {
  this() {
    import silver.core.game.DamageType;
    this.name = "battleaxe";
    this.damageDice = 8;
    this.damageType = DamageType.SLASHING;
  }
}
