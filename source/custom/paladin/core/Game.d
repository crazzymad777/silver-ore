module custom.paladin.core.Game;

import core.world.utils.GlobalCubeCoordinates;
import custom.paladin.core.World;
import core.game.Mob;
import core.game.IGame;
import core.Engine;

class Game : IGame {
  import core.engine.EngineMessenger;
  import core.game.animals.Lion;
  import custom.paladin.world.TextState;
  import core.game.humanoids.Humanoid;
  import custom.paladin.core.Stats;

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
  EngineMessenger messenger;
  private Humanoid paladin;
  private Lion pet;
  private Engine engine;
  this() {
    messenger = new EngineMessenger(GAME_ACTOR_ID);
    engine = new Engine();
    world = new World();

    engine.feed(messenger.assignWorld(world));

    import core.game.monsters.GiantSpider;

    paladin = new Humanoid(this);
    auto lion = new Lion(this);
    pet = lion;
    engine.feed(messenger.assignMob(paladin));
    engine.feed(messenger.assignMob(lion));

    auto spider1 = new GiantSpider(this);
    engine.feed(messenger.assignMob(spider1));
    engine.feed(messenger.mobSetPosition(spider1, GlobalCubeCoordinates(0, -16, 0)));

    auto spider2 = new GiantSpider(this);
    engine.feed(messenger.assignMob(spider2));
    engine.feed(messenger.mobSetPosition(spider2, GlobalCubeCoordinates(0, -16, 0)));

    auto spider3 = new GiantSpider(this);
    engine.feed(messenger.assignMob(spider3));
    engine.feed(messenger.mobSetPosition(spider3, GlobalCubeCoordinates(0, -16, 0)));

    // TODO: messaging
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
    engine.feed(messenger.toggleMobFollow(pet, paladin));
  }

  Mob[] getMobs(GlobalCubeCoordinates coors = GlobalCubeCoordinates(0, 0, 0)) {
    return engine.mobs;
  }

  void process() {
    engine.feed(messenger.process());
    count = engine.count;
  }

  long getTick() {
    return count;
  }

  Mob getMob(GlobalCubeCoordinates b) {
    auto mobs = getMobs();
    foreach (mob; engine.mobs) {
      if (mob.position == b) {
        return mob;
      }
    }
    return null;
  }

  Mob getPaladin() {
    return paladin;
  }

  bool EndCondition() {
    if (!engine.mobs[2].isAlive() && !engine.mobs[3].isAlive() && !engine.mobs[4].isAlive()) {
      return true;
    }

    if (!paladin.isAlive()) {
      return true;
    }

    return false;
  }
}
