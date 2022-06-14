module core.game.IGame;

import core.world.utils.GlobalCubeCoordinates;
import core.game.Mob;

interface IGame {
    bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b);
    /* bool hasApocalypseHappened(); */
    void process();
    long getTick();
    Mob[] getMobs(GlobalCubeCoordinates coors = GlobalCubeCoordinates(0, 0, 0));
    Mob getMob(GlobalCubeCoordinates b);
    void takenDamage(Mob mob, Mob damager, int damage);
}
