module custom.traveler.core.Game;

import core.world.utils.GlobalCubeCoordinates;
import core.world.IWorld;
import core.game.Mob;
import core.game.IGame;
import core.Engine;

class Game : IGame {
  import core.engine.EngineMessenger;
  import core.game.animals.Lion;
  import core.game.humanoids.Humanoid;
  import core.world.World;

  World world;
  IWorld getWorld() {
    return world;
  }

  void takenDamage(Mob mob, Mob damager, int damage) {
    /* stats.entries[mob.getName()].hitsTaken++;
    stats.entries[mob.getName()].damageTaken += damage;

    stats.entries[damager.getName()].hits++;
    stats.entries[damager.getName()].damage += damage; */
  }

  long count = 0;
  EngineMessenger messenger;
  private Humanoid traveler;
  private Lion pet;
  private Engine engine;

  // actually awful constructor
  this() {
    engine = new Engine();
    messenger = new EngineMessenger(GAME_ACTOR_ID, engine);
    world = new World();

    messenger.assignWorld(world);

    traveler = new Humanoid(this);
    auto lion = new Lion(this);
    pet = lion;
    messenger.assignMob(traveler);
    messenger.assignMob(lion);

    messenger.setFriend(lion, traveler);
    messenger.mobSetFollowed(lion, traveler);

    auto coors = world.getDefaultCoordinates();
    messenger.mobSetPosition(traveler, coors);
    messenger.mobSetPosition(lion, coors);
  }

  bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
    return world.checkColision(a, b);
  }

  void follow() {
    messenger.toggleMobFollow(pet, traveler);
  }

  Mob[] getMobs(GlobalCubeCoordinates coors = GlobalCubeCoordinates(0, 0, 0)) {
    return engine.mobs;
  }

  void process() {
    messenger.process();
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

  Mob getTraveler() {
    return traveler;
  }

  bool EndCondition() {
    if (!traveler.isAlive()) {
      return true;
    }

    return false;
  }
}
