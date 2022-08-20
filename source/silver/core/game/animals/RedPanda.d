module silver.core.game.animals.RedPanda;

import core.game.Mob;
import core.game.IGame;
import silver.core.game.animals.Animal;

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

  override void onDie() {
    super.onDie();
    game.requestRedPandaGuard(cast(Animal)this);
  }

  override void process() {
    super.process();
  }
}
