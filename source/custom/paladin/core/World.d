module custom.paladin.world.World;

import core.world.utils.GlobalCubeCoordinates;
import custom.paladin.world.Generator;
import core.world.Cube;
import core.world.IWorld;
import core.game.Mob;

import terminal.AbstractComponent;
import core.Observer;

class World : IWorld {
    import core.time;
    import custom.paladin.world.TextState;
    import core.game.humanoids.Humanoid;
    import core.game.animals.Lion;

    TextState textState;
    this() {
      import core.game.monsters.GiantSpider;

      before = MonoTime.currTime;
      paladin = new Humanoid(this);
      auto lion = new Lion(this);
      mobs ~= paladin;
      mobs ~= lion;
      mobs ~= new GiantSpider(this);

      lion.friends ~= paladin;
      lion.followed = paladin;

      textState = new TextState();
    }

    Mob[] friends() {
      return [mobs[1]];
    }

    void follow() {
      auto mob = mobs[1];
      auto lion = cast(Lion) mob;
      if (lion.followed is null) {
        lion.followed = paladin;
      } else {
        lion.followed = null;
      }
    }

    long count = 0;
    private Generator generator = new Generator();
    private Humanoid paladin;
    private Mob[] mobs;
    Cube getCube(GlobalCubeCoordinates coors) {
      return generator.getCube(coors);
    }

    Mob[] getMobs() {
      return mobs;
    }

    MonoTime before;
    void process() {
      MonoTime after = MonoTime.currTime;
      Duration timeElapsed = after - before;
      if (timeElapsed.total!"msecs" > 100) {
        foreach(mob; mobs) {
          mob.process();
        }
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
