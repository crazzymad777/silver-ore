module core.game.humanoids.Humanoid;

import silver.core.game.animals.Animal;
import core.game.IGame;

class Humanoid : Animal {
  import silver.core.game.Item;
  struct Equipment {
    Item right_hand;
    Item left_hand;
  }
  Equipment equipment;

  this(IGame game) {
    super(game);
    this.name = "humanoid";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 1;
    this.disableAI = true;
  }

  import core.game.Mob;
  final override void attackMob(Mob mob) {
    import std.random;
    // armor
    if (uniform!"[]"(0, 8) == 0) {
      int damage = 0;
      int damageDice = getDamageDice();
      if (damageDice > 0) {
        damage = uniform!"[]"(1, damageDice);
      }
      mob.takeDamage(damage, this);
      this.triggeredFoe = mob;
    }
    this.dropStamina();
  }

  final int getDamageDice() {
    import silver.core.game.Weapon;
    if (auto weapon = cast(Weapon) equipment.right_hand) {
      return weapon.damageDice;
    }
    if (auto weapon = cast(Weapon) equipment.left_hand) {
      return weapon.damageDice;
    }
    return this.damageDice;
  }

  override void process() {
    super.process();
  }
}
