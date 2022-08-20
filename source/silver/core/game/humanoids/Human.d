module silver.core.game.humanoids.Human;

import core.game.humanoids.Humanoid;
import core.game.IGame;

class Human : Humanoid {
  this(IGame game) {
    super(game);
    this.name = "human";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;
  }

  override void process() {
    super.process();
  }
}
