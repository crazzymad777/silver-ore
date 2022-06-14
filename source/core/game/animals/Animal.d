module core.game.animals.Animal;

import core.game.Mob;
import core.world.IWorld;

class Animal : Mob {
  Mob[] friends;
  Mob followed;
  this(IWorld world) {
    super(world);
    this.name = "animal";
  }

  override void process() {
    import std.math, std.conv: to;
    if (followed is null) {
      import std.random;
      if (uniform!"[)"(0, 7) == 0) {
        move(uniform!"[]"(-1, 1), uniform!"[]"(-1, 1));
      }
    } else {
      auto dx = followed.position.x-this.position.x;
      auto dy = followed.position.y-this.position.y;
      auto disX = abs(dx);
      auto disY = abs(dy);

      if (disX+disY > 3) {
        move(to!int(sgn(dx)), to!int(sgn(dy)));
      }
    }
    super.process();
  }
}
