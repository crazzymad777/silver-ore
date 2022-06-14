module core.game.animals.Animal;

import core.game.Mob;
import core.world.IWorld;
import core.world.utils.GlobalCubeCoordinates;

class Animal : Mob {
  Mob[] friends;
  Mob[] foes;
  Mob triggeredFoe;
  Mob followed;
  bool disableAI = false;
  this(IWorld world) {
    super(world);
    this.name = "animal";
    this.damageDice = 1;
  }

  override void takeDamage(int damage, Mob mob) {
    foreach (fren; friends) {
      if(cast(Animal) fren) {
        Animal animal = cast(Animal) fren;
        animal.followed = mob;
        animal.foes ~= mob;
      }
    }

    trigger(mob);
    super.takeDamage(damage, mob);
  }

  void trigger(Mob mob) {
    if (!isFriend(mob)) {
      if(!isFoe(mob)) {
        foes ~= mob;
      }
      followed = mob;
      triggeredFoe = mob;
    }
  }

  Mob getTriggeredFoe() {
    return triggeredFoe;
  }

  // TODO: make some team system
  override bool isFoe(Mob mob) {
    import std.algorithm: canFind;
    if (foes.canFind(mob)) {
      return true;
    }
    return false;
  }

  bool isFriend(Mob mob) {
    import std.algorithm: canFind;
    if (friends.canFind(mob)) {
      return true;
    }
    return false;
  }

  override void attack() {
    import std.math, std.conv: to;
    import std.random;

    auto mobs = world.getMobs();
    foreach (mob; mobs) {
      if (mob != this) {
        auto dx = abs(mob.position.x-this.position.x);
        auto dy = abs(mob.position.y-this.position.y);
        if (dx <= 1 && dy <= 1) {
          if (mob.isAlive()) {
            if (isFoe(mob)) {

              // armor
              if (uniform!"[]"(0, 8) == 0) {
                int damage = 0;
                if (this.damageDice > 0) {
                  damage = uniform!"[]"(1, this.damageDice);
                }
                mob.takeDamage(damage, this);
                break;
              }
              this.dropStamina();
            }
          }
        }
      }
    }
  }

  override bool move(int x = 0, int y = 0, int z = 0) {
    auto mob = world.getMob(GlobalCubeCoordinates(position.x + x, position.y + y, position.z + z));
    if (mob !is null) {
      if (Animal animal = cast(Animal) mob) {
        if (animal.isFoe(this)) {
          return false;
        }
      }
    }
    return super.move(x, y, z);
  }

  override void process() {
    import std.math, std.conv: to;
    import std.random;

    if (!disableAI) {
      if (isAlive()) {
        attack();


        bool customMove = true;
        if (followed !is null) {
          customMove = false;
          auto dx = followed.position.x-this.position.x;
          auto dy = followed.position.y-this.position.y;
          auto disX = abs(dx);
          auto disY = abs(dy);

          if (disX+disY > 3) {
            move(to!int(sgn(dx)), to!int(sgn(dy)));
          } else {
            customMove = true;
          }

          if (this.isFoe(followed) && !followed.isAlive()) {
            followed = null;
          }
        }

        if (customMove) {
          if (uniform!"[)"(0, 7) == 0) {
            move(uniform!"[]"(-1, 1), uniform!"[]"(-1, 1));
          }
        }
      }
    }
    super.process();
  }
}
