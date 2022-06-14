module core.world.IWorld;

import core.world.utils.GlobalCubeCoordinates;
import core.game.Mob;

interface IWorld {
    bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b);
    bool hasApocalypseHappened();
    void process();
    long getTick();
    Mob[] getMobs(GlobalCubeCoordinates coors = GlobalCubeCoordinates(0, 0, 0));
}
