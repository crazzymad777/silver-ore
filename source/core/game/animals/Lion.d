module core.game.animals.Lion;

import core.game.Mob;
import core.game.IGame;
import core.game.animals.Animal;

class Lion : Animal {
  this(IGame game) {
    super(game);
    this.name = "lion";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 8;
  }

  override void process() {
    super.process();
  }
}
