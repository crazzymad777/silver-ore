package silver.ore.app

import kotlin.random.Random

abstract class Generator(val random: Random = Random(0)) {
    abstract fun getCube(x: Int, y: Int, z: Int): Cube
}
