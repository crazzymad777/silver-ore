package silver.ore.app.utils

import silver.ore.app.ClusterId

data class ClusterTransformer(val clusterId: ClusterId) {
    private val offsetX = clusterId.x*256
    private val offsetY = clusterId.y*256
    fun getClusterCubeCoordinates(coors: GlobalCubeCoordinates): ClusterCubeCoordinates {
        return ClusterCubeCoordinates(coors.x-offsetX, coors.y-offsetY, coors.z)
    }
}
