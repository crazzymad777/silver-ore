module core.game.animals.Lion;

import core.game.Mob;
import core.world.IWorld;
import core.game.animals.Animal;

class Lion : Animal {
  this(IWorld world) {
    super(world);
    this.name = "lion";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;
  }

  override void process() {
    super.process();
  }
}
