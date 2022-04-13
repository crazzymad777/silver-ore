package silver.ore.core.generator

import silver.ore.core.AbstractGenerator
import silver.ore.core.ClusterId
import silver.ore.core.Cube
import silver.ore.core.utils.GlobalCubeCoordinates


class OreGenerator(private val version: Int = 1, private val seed: Long) : AbstractGenerator() {
    private val clusters = HashMap<ClusterId, ClusterOreGenerator>()

    private fun getClusterOreGenerator(clusterId: ClusterId): ClusterOreGenerator {
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
