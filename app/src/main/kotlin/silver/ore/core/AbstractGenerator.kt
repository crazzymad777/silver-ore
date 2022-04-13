package silver.ore.core

import silver.ore.core.utils.GlobalCubeCoordinates

abstract class AbstractGenerator() {
    abstract fun getCube(coors: GlobalCubeCoordinates): Cube?
}
