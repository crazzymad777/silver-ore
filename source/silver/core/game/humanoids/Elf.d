module silver.core.game.humanoids.Elf;

import core.game.humanoids.Humanoid;
import silver.core.game.IGame;

class Elf : Humanoid {
  this(IGame game) {
    super(game);
    this.name = "elf";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;
  }

  override void process() {
    super.process();
  }
}
