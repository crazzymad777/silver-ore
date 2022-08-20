module core.game.animals.RedPanda;

import core.game.Mob;
import core.game.IGame;
import core.game.animals.Animal;

// Ailurus fulgens
class RedPanda : Animal {
  this(IGame game) {
    super(game);
    this.name = "red panda";
    this.maxStamina = 42;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 8;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 4;
  }

  override void process() {
    super.process();
  }
}
