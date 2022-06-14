module custom.paladin.world.World;

import core.world.utils.GlobalCubeCoordinates;
import custom.paladin.world.Generator;
import core.world.Cube;
import core.world.IWorld;
import core.game.humanoids.Humanoid;
import core.game.Mob;

import terminal.AbstractComponent;
import core.Observer;

class World : IWorld {
    import core.time;
    this() {
      /* new Observer(component, this); */
      before = MonoTime.currTime;
      paladin = new Humanoid(this);
    }

    long count = 0;
    private Generator generator = new Generator();
    private Humanoid paladin;
    Cube getCube(GlobalCubeCoordinates coors) {
      return generator.getCube(coors);
    }

    MonoTime before;
    void process() {
      MonoTime after = MonoTime.currTime;
      Duration timeElapsed = after - before;
      if (timeElapsed.total!"msecs" > 100) {
        paladin.process();
        count++;
        before = MonoTime.currTime;
      }
    }

    long getTick() {
      return count;
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

      if (abs(a.x-b.x) > 1 || abs(a.y-b.y) > 1) {
        return false;
      }
      return true;
    }

    long cubesLoaded() {
      return generator.cubesLoaded();
    }

    Mob getPaladin() {
      return paladin;
    }

    bool isEndOfTime = false;
    void apocalypse() {
      isEndOfTime = true;
    }

    bool hasApocalypseHappened() {
      return isEndOfTime;
    }
}
