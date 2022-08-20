module silver.core.game.humanoids.DarkElf;

import core.game.humanoids.Humanoid;
import core.game.IGame;

class DarkElf : Humanoid {
  this(IGame game) {
    super(game);
    this.name = "dark elf";
    this.maxStamina = 40;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;
  }

  override void process() {
    super.process();
  }
}
