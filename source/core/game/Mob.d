module core.game.Mob;

import core.world.utils.GlobalCubeCoordinates;
import core.game.Item;
import core.game.IGame;

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

  IGame game;
  long lastCount = 0;
  this(IGame game) {
    this.name = "mob";
    this.game = game;
  }

  void takeDamage(int damage, Mob mob) {
    hitpoints -= damage;
    dropStamina();
    game.takenDamage(this, mob, damage);
  }

  void dropStamina() {
    if (stamina + 8 < maxStamina/2) {
      stamina = 0;
    } else {
      stamina /= 2;
    }
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

    auto tick = game.getTick();
    if (stamina > 0 || tick % 3 == 0) {
      if (!game.checkColision(position, newPosition)) {
        position = newPosition;
      }
    }
    if (stamina < maxStamina && restCount > 16 && isAlive()) stamina++;
    if (isAlive() && game.getTick() % 16 == 0) {
      if (hitpoints < maxHitpoints) {
        hitpoints++;
      }
    }
    lastCount = tick;
  }

  bool move(int x = 0, int y = 0, int z = 0) {
    /* newPosition = position;
    atomicOp!"+="(newPosition.x, x);
    atomicOp!"+="(newPosition.y, y);
    atomicOp!"+="(newPosition.z, z); */
    if (isAlive()) {
      auto coors = GlobalCubeCoordinates(position.x + x, position.y + y, position.z + z);
      if (!game.checkColision(position, coors)) {
        newPosition = coors;

        auto tick = game.getTick();
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
