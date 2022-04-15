package silver.ore.core.world

import silver.ore.core.world.utils.GlobalCubeCoordinates

abstract class AbstractGenerator() {
    abstract fun getCube(coors: GlobalCubeCoordinates): Cube?
}
