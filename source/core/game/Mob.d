module core.game.Mob;

import core.world.utils.GlobalCubeCoordinates;
import core.game.Item;
import core.world.IWorld;

import core.atomic : atomicOp, atomicLoad;

class Mob : Item {
  import core.time;
  GlobalCubeCoordinates position;
  GlobalCubeCoordinates newPosition;
  int hitpoints = 1;
  int maxHitpoints = 1;
  int maxStamina = 3;
  int stamina = 3;
  int restCount = 0;

  int damageDice;

  IWorld world;
  long lastCount = 0;
  this(IWorld world) {
    this.name = "mob";
    this.world = world;
  }

  void takeDamage(int damage, Mob mob) {
    hitpoints -= damage;
  }

  bool isFoe(Mob mob) {
    return false;
  }

  void attack() {

  }

  bool isAlive() {
    return hitpoints > 0;
  }

  void process() {
    if (position == newPosition) {
      restCount++;
    } else {
      if (restCount >= 16) {
        restCount = 16;
      }
      if (restCount > 0) restCount--;
    }

    auto tick = world.getTick();
    if (stamina > 0 || tick % 3 == 0) {
      if (!world.checkColision(position, newPosition)) {
        position = newPosition;
      }
    }
    if (stamina < maxStamina && restCount > 16) stamina++;
    lastCount = tick;
  }

  bool move(int x = 0, int y = 0, int z = 0) {
    /* newPosition = position;
    atomicOp!"+="(newPosition.x, x);
    atomicOp!"+="(newPosition.y, y);
    atomicOp!"+="(newPosition.z, z); */
    if (isAlive()) {
      auto coors = GlobalCubeCoordinates(position.x + x, position.y + y, position.z + z);
      if (!world.checkColision(position, coors)) {
        newPosition = coors;

        auto tick = world.getTick();
        if (lastCount != tick) {
          if (stamina > 0) {
            stamina -= 2;
          }
          lastCount = tick;
        }
        return true;
      }
    }
    return false;
  }
}
