package silver.ore.core

import silver.ore.core.utils.GlobalCubeCoordinates
import silver.ore.core.utils.WorldChunkCoordinates
import kotlin.random.Random

class World(private val config: WorldConfig = WorldConfig(generatorName = "flat")) {
    private val map = Map(Random(config.seed))
    private val generator = Generator(config.seed, map, config.generatorName)

    private val clusters = HashMap<ClusterId, Cluster>()

    fun getDefaultCoordinates(): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(
            (map.humanTownClusterId.x*256+128).toLong(),
            (map.humanTownClusterId.y*256+128).toLong(),
        128)
    }

    fun oreGeneratorsLoaded(): Int {
        return generator.oreGenerator.loaded()
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
        cluster = Cluster(clusterId, generator.getGenerator(clusterId))

        clusters[clusterId] = cluster
        return cluster
    }

    fun getCube(coors: GlobalCubeCoordinates): Cube {
        if (!config.enableNegativeCoordinates) {
            if (coors.x < 0 || coors.y < 0) {
                return Cube(Material.VOID, Material.VOID)
            }
        }

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
