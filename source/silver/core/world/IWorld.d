module core.world.IWorld;

import core.world.utils.GlobalCubeCoordinates;
import core.world.Cube;
import core.game.Mob;

interface IWorld {
    bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b);
    Cube getCube(GlobalCubeCoordinates coors);
    /* bool hasApocalypseHappened(); */
    /* void process(); */
    /* long getTick(); */
    /* Mob[] getMobs(GlobalCubeCoordinates coors = GlobalCubeCoordinates(0, 0, 0)); */
    /* Mob getMob(GlobalCubeCoordinates b); */
}
