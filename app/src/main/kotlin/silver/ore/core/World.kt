package silver.ore.core

import silver.ore.core.utils.GlobalCubeCoordinates
import silver.ore.core.utils.WorldChunkCoordinates
import kotlin.random.Random

class World(config: WorldConfig = WorldConfig(generatorName = "flat")) {
    private val map = Map(Random(config.seed))
    private val generator = Generator(config.seed, map, config.generatorName)

    private val clusters = HashMap<ClusterId, Cluster>()
    private val generators = HashMap<ClusterId, ClusterGenerator>()

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

    fun getCluster(chunkCoors: WorldChunkCoordinates): Cluster {
        val clusterId = chunkCoors.getClusterId()
        var cluster = clusters[clusterId]
        if (cluster != null) {
            return cluster
        }

        // WARNING! Not reproducible way. Should be refactored. Some day.
        val gen = generator.getGenerator(clusterId)
        generators[clusterId] = gen
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
