package silver.ore.app

import silver.ore.app.generator.Flat
import silver.ore.app.generator.OreGenerator
import silver.ore.app.generator.Sea
import silver.ore.app.generator.i1
import kotlin.random.Random

// Выдавать кубы должны генераторы и должен делать это так, чтобы кубы можно было воспроизвести.
class Generator(seed: Long, private val map: Map, private val generatorName: String = "flat") {
    val oreGenerator = OreGenerator(seed = seed)
    private val random = Random(seed)

    private val flatGenerator = Flat(this)
    private val generators = HashMap<ClusterId, ClusterGenerator>()
    // Passing `random` can break reproducing
    private val i1Generator = i1(seed, random, this)

    fun getGenerator(clusterId: ClusterId): ClusterGenerator {
        val tile = map.getTile(clusterId)
        val type = tile.type

        if (type == Tile.TYPE.TOWN && generatorName == "i1") {
            return i1Generator
        } else if (type == Tile.TYPE.SEA) {
            var seaGenerator = generators[clusterId]
            if (seaGenerator != null) {
                return seaGenerator
            }

            val neighbourhood = clusterId.getNeighbourhood()
            val tiles = neighbourhood.map { x -> map.getTileType(x) }
            // better to create sea generators for each configuration
            seaGenerator = Sea(this, tiles)
            generators[clusterId] = seaGenerator
            return seaGenerator
        }

        return flatGenerator
    }
}
