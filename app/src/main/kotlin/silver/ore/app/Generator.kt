package silver.ore.app

import silver.ore.app.generator.Building
import kotlin.random.Random

abstract class Generator(val random: Random = Random(0)) {
    abstract fun getCube(x: Int, y: Int, z: Int): Cube
}
