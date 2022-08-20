module silver.core.game.animals.Fox;

import core.game.Mob;
import core.game.IGame;
import silver.core.game.animals.Animal;

class Fox : Animal {
  this(IGame game) {
    super(game);
    this.name = "fox";
    this.maxStamina = 42;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 16;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 6;
  }

  override void process() {
    super.process();
  }
}
