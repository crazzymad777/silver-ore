package silver.ore.core.world.generator

import silver.ore.core.world.AbstractGenerator
import silver.ore.core.world.ClusterId
import silver.ore.core.world.Cube
import silver.ore.core.world.utils.ClusterTransformer
import silver.ore.core.world.utils.GlobalCubeCoordinates


class OreGenerator(private var version: Int = 1, private val seed: Long) : AbstractGenerator() {
    private val clusters = hashMapOf<ClusterOreGeneratorId, ClusterOreGenerator>()

    fun loaded(): Int {
        return clusters.count()
    }

    private fun getClusterOreGenerator(clusterId: ClusterId): ClusterOreGenerator {
        val id = ClusterOreGeneratorId(version, seed, clusterId)

        var cluster = clusters[id]
        if (cluster != null) {
            return cluster
        }

        cluster = ClusterOreGenerator(id)
        clusters[id] = cluster
        return cluster
    }

    override fun getCube(coors: GlobalCubeCoordinates): Cube? {
        val clusterId = coors.getChunkCoordinates().getClusterId()
        val clusterTransformer = ClusterTransformer(clusterId)
        val cluster = getClusterOreGenerator(clusterId)
        return cluster.getCube(clusterTransformer.getClusterCubeCoordinates(coors))
    }
}
