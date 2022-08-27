module silver.core.game.utils.RedPandaGuard;

import silver.core.game.monsters.Edward;
import silver.core.engine.EngineMessenger;
import silver.core.game.animals.Animal;
import silver.core.game.IGame;
Edward createRedPandaGuard(IGame game, EngineMessenger messenger, Animal mob) {
  auto edward = new Edward(game);
  messenger.assignMob(edward);
  messenger.mobSetPosition(edward, mob.position);
  foreach(foe; mob.foes) {
    messenger.setFoe(edward, foe);
  }
  foreach(friend; mob.friends) {
    messenger.setFriend(edward, friend);
  }
  return edward;
}
