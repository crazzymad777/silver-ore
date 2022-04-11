package silver.ore.app

import silver.ore.app.generator.OreGenerator
import kotlin.random.Random

// Нужно как-то связать этот генератор с картой и кластерами. Выдавать кубы должен генератор и должен делать это так, чтобы кубы можно было воспроизвести.
abstract class WorldGenerator(random: Random = Random(0)): AbstractGenerator(random) {
//    abstract fun getCube(x: Int, y: Int, z: Int): Cube?
    val oreGenerator = OreGenerator(random)
}
