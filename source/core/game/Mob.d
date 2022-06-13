module core.game.Mob;

import core.world.utils.GlobalCubeCoordinates;
import core.game.Item;
import core.world.IWorld;

import core.atomic : atomicOp, atomicLoad;

class Mob : Item {
  GlobalCubeCoordinates position;
  GlobalCubeCoordinates newPosition;
  int maxStamina = 3;
  int stamina = 3;

  this() {
    this.name = "mob";
  }

  void process(IWorld world) {
    if (stamina > 0) {
      if (!world.checkColision(position, newPosition)) {
        position = newPosition;
      }
    }
    if (stamina < maxStamina) stamina++;
  }

  void move(int x = 0, int y = 0, int z = 0) {
    /* newPosition = position;
    atomicOp!"+="(newPosition.x, x);
    atomicOp!"+="(newPosition.y, y);
    atomicOp!"+="(newPosition.z, z); */
    newPosition = position;
    newPosition.x += x;
    newPosition.y += y;
    newPosition.z += z;
    if (stamina > -1) stamina--;
  }
}
