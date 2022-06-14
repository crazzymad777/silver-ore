module core.game.humanoids.Humanoid;

import core.game.animals.Animal;
import core.world.IWorld;

class Humanoid : Animal {
  this(IWorld world) {
    super(world);
    this.name = "humanoid";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;

    // For Paladin with Hammer 8
    this.damageDice = 8;
    this.disableAI = true;
  }

  override void process() {
    super.process();
  }
}
