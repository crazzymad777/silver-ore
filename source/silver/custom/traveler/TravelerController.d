module custom.traveler.TravelerController;

import custom.traveler.core.Game;
import core.game.Mob;

import core.world.utils.GlobalCubeCoordinates;
import core.world.Cube;

interface ITravelerController {
  static TravelerControllerImpl getImplementation() {
    return new TravelerControllerImpl();
  }

  void process();
  void resetGame();
  void move(int x = 0, int y = 0, int z = 0);
  void attack();
  void follow();
  Mob getTraveler();
  Mob[] getMobs();
  long count();
  long cubesLoaded();

  bool endCondition();
  long getTick();
  bool checkVisible(GlobalCubeCoordinates a, GlobalCubeCoordinates b);
  Cube getCube(GlobalCubeCoordinates coors);

  import silver.core.world.IWorld;
  IWorld getWorld();
}

class TravelerControllerImpl : ITravelerController {
  private Game game;
  this() {
    import relay.Client;
    this.game = new Game();
    new Client!("selfhost",int)();
  }

  import silver.core.world.IWorld;
  IWorld getWorld() {
    return game.getWorld();
  }

  void process() {
    game.process();
  }

  void resetGame() {
    if (game.EndCondition()) {
      game = new Game();
    }
  }

  void move(int x, int y, int z) {
    game.getTraveler().move(x, y, z);
  }

  void attack() {
    game.getTraveler().attack();
  }

  void follow() {
    game.follow();
  }

  Mob getTraveler() {
    return game.getTraveler();
  }

  Mob[] getMobs() {
    return game.getMobs();
  }

  long count() {
    return game.count;
  }

  long cubesLoaded() {
    return game.world.cubesLoaded();
  }

  bool endCondition() {
    return game.EndCondition();
  }

  long getTick() {
    return game.getTick();
  }

  bool checkVisible(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
    /* return game.world.checkVisible(a, b); */
    return true;
  }

  Cube getCube(GlobalCubeCoordinates coors) {
    return game.world.getCube(coors);
  }
}
