package silver.ore.core.utils

import silver.ore.core.ClusterId

data class ClusterTransformer(val clusterId: ClusterId) {
    private val offsetClusterId = ClusterId(clusterId.x, clusterId.y)
//    init {
//        if (offsetClusterId.x < 0) {
//            offsetClusterId.x++
//        }
//        if (offsetClusterId.y < 0) {
//            offsetClusterId.y++
//        }
//    }
    private val offsetX = offsetClusterId.x*256
    private val offsetY = offsetClusterId.y*256

    fun getClusterCubeCoordinates(coors: GlobalCubeCoordinates): ClusterCubeCoordinates {
        val x = coors.x-offsetX
        val y = coors.y-offsetY
        return ClusterCubeCoordinates(x, y, coors.z)
    }

    fun getGlobalCubeCoordinates(clusterCoors: ClusterCubeCoordinates): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(clusterCoors.x+offsetX, clusterCoors.y+offsetY, clusterCoors.z)
    }
}
