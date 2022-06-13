module core.world.IWorld;

import core.world.utils.GlobalCubeCoordinates;

interface IWorld {
    bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b);
}
