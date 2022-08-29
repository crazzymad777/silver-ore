module silver.core.game.animals.FlyingAnimal;

import silver.core.game.IGame;
import silver.core.game.animals.Animal;

class FlyingAnimal : Animal {
  protected bool flying = false;
  this(IGame game) {
    super(game);
    this.name = "flying animal";
  }

  override void process() {
    super.process();
  }

  bool isAbleToFly() {
    return isAlive();
  }

  void fly() {
    if (isAbleToFly()) {
      flying = true;
    }
  }

  void walk() {
    flying = false;
  }
}
