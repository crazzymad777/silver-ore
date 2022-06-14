module core.game.monsters.GiantSpider;

import core.game.Mob;
import core.world.IWorld;
import core.game.monsters.Monster;

class GiantSpider : Monster {
  this(IWorld world) {
    super(world);
    this.name = "giant spider";
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 32;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 8;
  }

  override void process() {
    super.process();
  }
}
