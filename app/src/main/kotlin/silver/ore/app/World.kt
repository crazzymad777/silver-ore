package silver.ore.app

import silver.ore.app.generator.Flat
import silver.ore.app.utils.GlobalCubeCoordinates
import silver.ore.app.utils.WorldChunkCoordinates
import kotlin.random.Random

// TODO: clusters. One cluster 16x16x16 chunks.

class World(config: WorldConfig = WorldConfig(generatorName = "flat")) {
    private val random = Random(config.seed)
    private val flatGenerator = Flat(config.seed, random)
    private val map = Map(random)
    private val generator = config.getGenerator(config.seed, random)
    private val clusters = HashMap<ClusterId, Cluster>()
    private val generators = HashMap<ClusterId, WorldGenerator>()

    fun getDefaultCoordinates(): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(map.humanTownClusterId.x*256+128, map.humanTownClusterId.y*256+128, 128)
    }

    fun clustersLoaded(): Int {
        return clusters.count()
    }

    fun chunksLoaded(): Int {
        return clusters.map { it.value.chunksLoaded() }.toTypedArray().sum()
    }

    fun cubesLoaded(): Int {
        return clusters.map { it.value.cubesLoaded() }.toTypedArray().sum()
    }

    fun getChunkByCoordinates(coors: GlobalCubeCoordinates): Chunk {
        val chunkCoors = coors.getChunkCoordinates()
        val cluster = getCluster(chunkCoors)
        return cluster.getLocalChunk(chunkCoors.getClusterChunkCoordinates())
    }

    private fun getCluster(chunkCoors: WorldChunkCoordinates): Cluster {
        val clusterId = chunkCoors.getClusterId()
        var cluster = clusters[clusterId]
        if (cluster != null) {
            return cluster
        }

        val tile = map.getTile(clusterId)
        var gen = generators[clusterId]
        // WARNING! Not reproducible way. Should be refactored. Some day.
        if (tile.type == Tile.TYPE.TOWN) {
            if (gen == null) {
                gen = generator
                generators[clusterId] = gen
            }
        } else {
            if (gen == null) {
                gen = flatGenerator
                generators[clusterId] = gen
            }
        }
        cluster = Cluster(clusterId, gen)

        clusters[clusterId] = cluster
        return cluster
    }

    fun getCube(coors: GlobalCubeCoordinates): Cube {
        if (coors.z < 0 || coors.z >= 256) {
            return Cube(Material.VOID, Material.VOID)
        }

        val chunkCoors = coors.getChunkCoordinates()
        val cluster = getCluster(chunkCoors)
        val chunk = cluster.getLocalChunk(chunkCoors.getClusterChunkCoordinates())

        val localCoors = cluster.clusterTransformer.getClusterCubeCoordinates(coors)
        return chunk.getLocalCube(chunk.chunkTransformer.getLocalCubeCoordinates(localCoors))
    }
}
