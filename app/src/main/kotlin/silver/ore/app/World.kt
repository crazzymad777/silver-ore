package silver.ore.app

import silver.ore.app.utils.GlobalCubeCoordinates
import silver.ore.app.utils.WorldChunkCoordinates
import kotlin.random.Random

// TODO: clusters. One cluster 16x16x16 chunks.

class World(config: WorldConfig = WorldConfig(generatorName = "flat")) {
    private val random = Random(config.seed)
    private val generator = config.getGenerator(random)
    private val clusters = HashMap<ClusterId, Cluster>()

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
        return cluster.getLocalChunk(chunkCoors.getClusterChunkCoordinates(), generator)
    }

    fun getCluster(chunkCoors: WorldChunkCoordinates): Cluster {
        val clusterId = chunkCoors.getClusterId()
        var cluster = clusters[clusterId]
        if (cluster != null) {
            return cluster
        }
        cluster = Cluster(clusterId)
        clusters[clusterId] = cluster
        return cluster
    }

    fun getCube(coors: GlobalCubeCoordinates): Cube {
//        if (coors.x < 0 || coors.x >= 256 || coors.z < 0 || coors.z >= 256 || coors.y < 0 || coors.y >= 256) {
//            return Cube(Material.VOID, Material.VOID)
//        }
        val chunkCoors = coors.getChunkCoordinates()
        val cluster = getCluster(chunkCoors)
        val chunk = cluster.getLocalChunk(chunkCoors.getClusterChunkCoordinates(), generator)
//        return chunk.getCube(coors)
        val localCoors = cluster.clusterTransformer.getClusterCubeCoordinates(coors)
        return chunk.getLocalCube(chunk.chunkTransformer.getLocalCubeCoordinates(localCoors))
    }
}
