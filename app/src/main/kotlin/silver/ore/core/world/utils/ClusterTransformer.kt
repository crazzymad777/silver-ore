package silver.ore.core.world.utils

import silver.ore.core.world.ClusterId

data class ClusterTransformer(val clusterId: ClusterId) {
    private val offsetClusterId = ClusterId(clusterId.getUnsignedX(), clusterId.getUnsignedY())
//    init {
//        if (offsetClusterId.x < 0) {
//            offsetClusterId.x++
//        }
//        if (offsetClusterId.y < 0) {
//            offsetClusterId.y++
//        }
//    }
    private val offsetX = offsetClusterId.getUnsignedX().toULong()*256u
    private val offsetY = offsetClusterId.getUnsignedY().toULong()*256u

    fun getClusterCubeCoordinates(coors: GlobalCubeCoordinates): ClusterCubeCoordinates {
        val x = (coors.x).toULong()-offsetX
        val y = (coors.y).toULong()-offsetY
        return ClusterCubeCoordinates(x.toUInt(), y.toUInt(), coors.z.toUInt())
    }

    fun getGlobalCubeCoordinates(clusterCoors: ClusterCubeCoordinates): GlobalCubeCoordinates {
        return GlobalCubeCoordinates.fromInternalCoordinates(
            clusterCoors.x + offsetX,
            clusterCoors.y + offsetY,
            clusterCoors.z.toULong()
        )
    }
}
