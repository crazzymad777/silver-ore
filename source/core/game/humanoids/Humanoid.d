module core.game.humanoids.Humanoid;

import core.game.Mob;
import core.world.IWorld;

class Humanoid : Mob {
  this(IWorld world) {
    this.maxStamina = 24;
    this.maxHitpoints = 32;
    this.hitpoints = 32;
    this.name = "humanoid";
    super(world);
  }
}
