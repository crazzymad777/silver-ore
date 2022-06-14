module custom.paladin.core.World;

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

      auto spider1 = new GiantSpider(this);
      spider1.position = GlobalCubeCoordinates(0, -16, 0);
      spider1.newPosition = GlobalCubeCoordinates(0, -16, 0);

      auto spider2 = new GiantSpider(this);
      spider2.position = GlobalCubeCoordinates(0, -16, 0);
      spider2.newPosition = GlobalCubeCoordinates(0, -16, 0);

      auto spider3 = new GiantSpider(this);
      spider3.position = GlobalCubeCoordinates(0, -16, 0);
      spider3.newPosition = GlobalCubeCoordinates(0, -16, 0);

      mobs ~= paladin;
      mobs ~= lion;
      mobs ~= spider1;
      mobs ~= spider2;
      mobs ~= spider3;

      paladin.friends ~= lion;
      paladin.foes ~= spider1;
      paladin.foes ~= spider2;
      paladin.foes ~= spider3;

      lion.friends ~= paladin;
      lion.followed = paladin;

      spider1.foes ~= paladin;
      spider2.foes ~= paladin;
      spider3.foes ~= paladin;

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
        if (lion.followed == paladin) {
          lion.followed = null;
        } else {
          lion.followed = paladin;
        }
      }
    }

    long count = 0;
    private Generator generator = new Generator();
    private Humanoid paladin;
    private Mob[] mobs;
    Cube getCube(GlobalCubeCoordinates coors) {
      return generator.getCube(coors);
    }

    Mob[] getMobs(GlobalCubeCoordinates coors = GlobalCubeCoordinates(0, 0, 0)) {
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

    Mob getMob(GlobalCubeCoordinates b) {
      auto mobs = getMobs();
      foreach (mob; mobs) {
        if (mob.position == b) {
          return mob;
        }
      }
      return null;
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
