package silver.ore.core.world

import silver.ore.core.world.generator.Flat
import silver.ore.core.world.generator.OreGenerator
import silver.ore.core.world.generator.Sea
import silver.ore.core.world.generator.i1
import kotlin.random.Random

// Выдавать кубы должны генераторы и должен делать это так, чтобы кубы можно было воспроизвести.
class Generator(private val seed: Long, private val map: Map, private val generatorName: String = "flat") {
    val oreGenerator = OreGenerator(seed = seed)
    private val random = Random(seed)

    private val flatGenerator = Flat(this)
    private val generators = HashMap<ClusterId, ClusterGenerator>()

    fun getGenerator(clusterId: ClusterId): ClusterGenerator {
        var generator = generators[clusterId]
        if (generator != null) {
            return generator
        }

        generator = createGenerator(clusterId)
        generators[clusterId] = generator

        return generator
    }

    fun createGenerator(clusterId: ClusterId): ClusterGenerator {
        val tile = map.getTile(clusterId)
        val type = tile.type

        if (type == Tile.TYPE.TOWN && generatorName == "i1") {
            return i1(seed, clusterId,this)
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
