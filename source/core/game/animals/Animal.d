module core.game.animals.Animal;

import core.game.Mob;
import core.world.IWorld;

class Animal : Mob {
  Mob[] friends;
  this(IWorld world) {
    super(world);
    this.name = "animal";
  }

  override void process() {
    import std.random;
    if (uniform!"[)"(0, 7) == 0) {
      move(uniform!"[]"(-1, 1), uniform!"[]"(-1, 1));
    }
    super.process();
  }
}
