package silver.ore.app

import silver.ore.app.utils.GlobalCubeCoordinates

abstract class AbstractGenerator() {
    abstract fun getCube(coors: GlobalCubeCoordinates): Cube?
}
