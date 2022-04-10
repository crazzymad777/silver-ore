package silver.ore.app

import silver.ore.app.generator.OreGenerator
import kotlin.random.Random

abstract class WorldGenerator(random: Random = Random(0)): AbstractGenerator(random) {
//    abstract fun getCube(x: Int, y: Int, z: Int): Cube?
    val oreGenerator = OreGenerator(random)
}
