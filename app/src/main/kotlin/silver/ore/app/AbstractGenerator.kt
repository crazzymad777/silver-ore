package silver.ore.app

import kotlin.random.Random

abstract class AbstractGenerator(val random: Random = Random(0)) {
    abstract fun getCube(x: Int, y: Int, z: Int): Cube?
}
