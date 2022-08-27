module silver.core.game.animals.Cat;

import core.game.Mob;
import silver.core.game.IGame;
import silver.core.game.animals.Animal;

class Cat : Animal {
  this(IGame game) {
    super(game);
    this.name = "cat";
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
