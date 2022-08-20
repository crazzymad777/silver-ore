module core.game.animals.Wolf;

import core.game.Mob;
import core.game.IGame;
import core.game.animals.Animal;

class Wolf : Animal {
  this(IGame game) {
    super(game);
    this.name = "wolf";
    this.maxStamina = 42;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 22;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 8;
  }

  override void process() {
    super.process();
  }
}
