package silver.ore.app

import silver.ore.app.generator.OreGenerator

// Нужно как-то связать этот генератор с картой и кластерами. Выдавать кубы должен генератор и должен делать это так, чтобы кубы можно было воспроизвести.
abstract class WorldGenerator(seed: Long): AbstractGenerator() {
//    abstract fun getCube(x: Int, y: Int, z: Int): Cube?
    val oreGenerator = OreGenerator(seed = seed)
}
