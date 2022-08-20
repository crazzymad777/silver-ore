module silver.core.game.animals.Dog;

import core.game.Mob;
import core.game.IGame;
import silver.core.game.animals.Animal;

class Dog : Animal {
  this(IGame game) {
    super(game);
    this.name = "dog";
    this.maxStamina = 42;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 22;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 6;
  }

  override void process() {
    super.process();
  }
}
