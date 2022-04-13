package silver.ore.app.utils

import silver.ore.app.ClusterId

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
        val x = (512+coors.x-offsetX)%256
        val y = (512+coors.y-offsetY)%256
        return ClusterCubeCoordinates(x, y, coors.z)
    }
}
