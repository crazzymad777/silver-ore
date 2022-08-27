module silver.core.game.humanoids.Orc;

import core.game.humanoids.Humanoid;
import silver.core.game.IGame;

class Orc : Humanoid {
  this(IGame game) {
    super(game);
    this.name = "orc";
    this.maxStamina = 28;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 40;
    this.hitpoints = this.maxHitpoints;
  }

  override void process() {
    super.process();
  }
}
