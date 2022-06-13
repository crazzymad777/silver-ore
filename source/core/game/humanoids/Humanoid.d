module core.game.humanoids.Humanoid;

import core.game.Mob;

class Humanoid : Mob {
  this() {
    this.maxStamina = 24;
    this.name = "humanoid";
  }
}
