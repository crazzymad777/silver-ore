package silver.ore.app.generator

import silver.ore.app.AbstractGenerator
import silver.ore.app.ClusterId
import silver.ore.app.Cube
import silver.ore.app.utils.GlobalCubeCoordinates


class OreGenerator(private val version: Int = 1, private val seed: Long) : AbstractGenerator() {
    private val clusters = HashMap<ClusterId, ClusterOreGenerator>()

    fun getClusterOreGenerator(clusterId: ClusterId): ClusterOreGenerator {
        var cluster = clusters[clusterId]
        if (cluster != null) {
            return cluster
        }
        cluster = ClusterOreGenerator(ClusterOreGeneratorId(version, seed, clusterId))
        clusters[clusterId] = cluster
        return cluster
    }

    override fun getCube(coors: GlobalCubeCoordinates): Cube? {
        val clusterId = coors.getChunkCoordinates().getClusterId()
        val cluster = getClusterOreGenerator(clusterId)
        return cluster.getCube(coors)
    }
}
