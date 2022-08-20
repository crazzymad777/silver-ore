module core.game.animals.Bear;

import core.game.Mob;
import core.game.IGame;
import silver.core.game.animals.Animal;

class Bear : Animal {
  this(IGame game) {
    super(game);
    this.name = "bear";
    this.maxStamina = 22;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 8;
  }

  override void process() {
    super.process();
  }
}
