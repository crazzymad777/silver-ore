module custom.paladin.PaladinController;

import custom.paladin.world.TextState;
import custom.paladin.core.Stats;
import custom.paladin.core.Game;
import core.game.Mob;

import core.world.utils.GlobalCubeCoordinates;
import core.world.IWorld;
import core.world.Cube;

interface IPaladinController {
  static PaladinControllerImpl getImplementation() {
    return new PaladinControllerImpl();
  }

  void process();
  void resetGame();
  void move(int x = 0, int y = 0);
  void attack();
  void follow();
  Mob getPaladin();
  Mob[] getMobs();
  long count();
  long cubesLoaded();
  Stats stats();
  TextState textState();

  bool endCondition();
  long getTick();
  bool checkVisible(GlobalCubeCoordinates a, GlobalCubeCoordinates b);
  Cube getCube(GlobalCubeCoordinates coors);

  IWorld getWorld();
}

class PaladinControllerImpl : IPaladinController {
  private Game game;
  this() {
    this.game = new Game();
  }

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

  void move(int x, int y) {
    game.getPaladin().move(x, y);
  }

  void attack() {
    game.getPaladin().attack();
  }

  void follow() {
    game.follow();
  }

  Mob getPaladin() {
    return game.getPaladin();
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

  Stats stats() {
    return game.stats;
  }

  TextState textState() {
    return game.textState;
  }

  bool endCondition() {
    return game.EndCondition();
  }

  long getTick() {
    return game.getTick();
  }

  bool checkVisible(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
    return game.world.checkVisible(a, b);
  }

  Cube getCube(GlobalCubeCoordinates coors) {
    return game.world.getCube(coors);
  }
}
