module core.game.monsters.Monster;

import silver.core.game.animals.Animal;
import core.game.Mob;
import silver.core.game.IGame;

class Monster : Animal {
  this(IGame game) {
    super(game);
    this.name = "monster";
    this.damageDice = 8;
  }

  // TODO: make some team system
  override bool isFoe(Mob mob) {
    if (cast(Monster) mob) {
      return false;
    }
    return true;
  }

  override void process() {
    super.process();
  }
}
