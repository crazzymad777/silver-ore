module core.game.monsters.GiantSpider;

import core.game.Mob;
import core.world.IWorld;
import core.game.monsters.Monster;

class GiantSpider : Monster {
  static spiderCount = 0;
  this(IWorld world) {
    spiderCount++;
    import std.format;
    super(world);
    this.name = format("giant spider (%d)", spiderCount);
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
