module custom.paladin.core.Game;

import core.world.utils.GlobalCubeCoordinates;
import custom.paladin.core.World;
import core.game.Mob;
import core.game.IGame;

class Game : IGame {
  import custom.paladin.world.TextState;
  import core.game.humanoids.Humanoid;
  import custom.paladin.core.Stats;
  import core.time;

  World world;
  TextState textState;
  Stats stats = new Stats();

  void takenDamage(Mob mob, Mob damager, int damage) {
    stats.entries[mob.getName()].hitsTaken++;
    stats.entries[mob.getName()].damageTaken += damage;

    stats.entries[damager.getName()].hits++;
    stats.entries[damager.getName()].damage += damage;
  }

  long count = 0;
  private Humanoid paladin;
  private Mob[] mobs;
  this() {
    world = new World();
    import core.game.monsters.GiantSpider;
    import core.game.animals.Lion;

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

    stats.addEntry(paladin.getName());
    stats.addEntry(lion.getName());

    stats.addEntry(spider1.getName());
    stats.addEntry(spider2.getName());
    stats.addEntry(spider3.getName());

    textState = new TextState();
  }

  bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
    return world.checkColision(a, b);
  }

  void follow() {
    import core.game.animals.Lion;
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

  Mob getPaladin() {
    return paladin;
  }
}
