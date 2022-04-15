package silver.ore.core.world

import silver.ore.core.game.Material
import silver.ore.core.world.utils.GlobalCubeCoordinates
import silver.ore.core.world.utils.WorldChunkCoordinates

class World(private val config: WorldConfig = WorldConfig(generatorName = "flat")) {
    val map = Map(config.seed)
    private val generator = Generator(config.seed, map, config.generatorName)

    private val clusters = HashMap<ClusterId, Cluster>()

    fun getDefaultCoordinates(): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(
            (map.defaultClusterId.getSignedX()*256+128).toLong(),
            (map.defaultClusterId.getSignedY()*256+128).toLong(),
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
