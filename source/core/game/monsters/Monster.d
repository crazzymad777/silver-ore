module core.game.monsters.Monster;

import core.game.animals.Animal;
import core.game.Mob;
import core.world.IWorld;

class Monster : Animal {
  this(IWorld world) {
    super(world);
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
