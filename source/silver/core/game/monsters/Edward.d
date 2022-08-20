module silver.core.game.monsters.Edward;

import core.game.Mob;
import core.game.IGame;
import core.game.monsters.Monster;

// Red Panda Guard
class Edward : Monster {
  static edwardCount = 0;
  this(IGame game) {
    super(game);

    edwardCount++;
    import std.format;
    this.name = format("Edward (%d)", edwardCount);
    this.maxStamina = 32;
    this.stamina = this.maxStamina;

    this.maxHitpoints = 64;
    this.hitpoints = this.maxHitpoints;

    this.damageDice = 32;
  }

  override void process() {
    super.process();
  }
}
