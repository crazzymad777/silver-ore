package silver.ore.app.utils

import silver.ore.app.ClusterId

data class ClusterTransformer(val clusterId: ClusterId) {
    private val offsetX = clusterId.x*256
    private val offsetY = clusterId.y*256

    fun getClusterCubeCoordinates(coors: GlobalCubeCoordinates): ClusterCubeCoordinates {
        val x = (256+coors.x-offsetX)%256
        val y = (256+coors.y-offsetY)%256
        return ClusterCubeCoordinates(x, y, coors.z)
    }
}
