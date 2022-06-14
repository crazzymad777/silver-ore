module custom.paladin.core.World;

import core.world.utils.GlobalCubeCoordinates;
import custom.paladin.world.Generator;
import core.world.Cube;
import core.world.IWorld;

import terminal.AbstractComponent;

class World : IWorld {
    private Generator generator = new Generator();
    Cube getCube(GlobalCubeCoordinates coors) {
      return generator.getCube(coors);
    }

    bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
      return getCube(b).wall.isSolid();
    }

    bool checkVisible(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
      import std.math;

      /* return true; */
      /* if (abs(b.x) <= 8 && abs(b.y) <= 8) {
        return true;
      } */

      if (abs(b.x) <= 1 && abs(b.y-(-8)) <= 1) {
        return true;
      }

      float disX = pow(a.x-b.x, 2);
      float disY = pow(a.y-b.y, 2);
      if (sqrt(disX+disY) > 7) {
        return false;
      }
      return true;
    }

    long cubesLoaded() {
      return generator.cubesLoaded();
    }
}
