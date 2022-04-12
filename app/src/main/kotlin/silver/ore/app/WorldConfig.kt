package silver.ore.app

import silver.ore.app.generator.Flat
import silver.ore.app.generator.i1
import kotlin.random.Random

class WorldConfig(val seed: Long = System.currentTimeMillis() / 1000L, var generatorName: String = "flat") {
    fun getGenerator(seed: Long, random: Random): WorldGenerator {
        if (generatorName == "i1") {
            return i1(seed, random)
        }
        return Flat(seed, random)
    }
}
