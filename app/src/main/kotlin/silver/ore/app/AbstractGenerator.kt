package silver.ore.app

import silver.ore.app.utils.GlobalCubeCoordinates
import kotlin.random.Random

abstract class AbstractGenerator(val random: Random = Random(0)) {
    abstract fun getCube(coors: GlobalCubeCoordinates): Cube?
}
