package silver.ore.app

import silver.ore.app.generator.Flat
import silver.ore.app.generator.OreGenerator
import silver.ore.app.generator.i1
import kotlin.random.Random

// Выдавать кубы должны генераторы и должен делать это так, чтобы кубы можно было воспроизвести.
class Generator(seed: Long, private val map: Map, private val generatorName: String = "flat") {
    val oreGenerator = OreGenerator(seed = seed)
    private val random = Random(seed)

    // Passing `random` can break reproducing
    private val flatGenerator = Flat(this)
    private val i1Generator = i1(seed, random, this)

    fun getGenerator(clusterId: ClusterId): ClusterGenerator {
        val tile = map.getTile(clusterId)
        val type = tile.type

        return if (type == Tile.TYPE.TOWN && generatorName == "i1") {
            i1Generator
        } else {
            flatGenerator
        }
    }
}
