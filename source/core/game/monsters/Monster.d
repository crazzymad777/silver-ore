module core.game.monsters.Monster;

import core.game.animals.Animal;
import core.game.Mob;
import core.world.IWorld;

class Monster : Animal {
  Mob[] foes;
  this(IWorld world) {
    super(world);
    this.name = "monster";
  }

  override void process() {
    super.process();
  }
}
