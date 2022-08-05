module core.game.monsters.GiantSpider;

import core.game.Mob;
import core.game.IGame;
import core.game.monsters.Monster;

class GiantSpider : Monster {
  static spiderCount = 0;
  this(IGame game) {
    super(game);

    spiderCount++;
    import std.format;
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
