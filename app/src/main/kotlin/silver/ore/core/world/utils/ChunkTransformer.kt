package silver.ore.core.world.utils

data class ChunkTransformer(val chunkId: UInt) {
    init {
        if (chunkId >= 4096u) {
            throw IllegalArgumentException("invalid chunkId: $chunkId")
        }
    }

    private val offsetX = (chunkId%16u)*16u
    private val offsetY = ((chunkId/16u)%16u)*16u
    private val offsetZ = (chunkId/(16u*16u))*16u

    fun makeClusterCubeCoordinates(coors: ChunkCubeCoordinates): ClusterCubeCoordinates {
        return ClusterCubeCoordinates(coors.x+offsetX, coors.y+offsetY, coors.z+offsetZ)
    }

    fun getLocalCubeCoordinates(coors: ClusterCubeCoordinates): ChunkCubeCoordinates {
        return ChunkCubeCoordinates(coors.x-offsetX, coors.y-offsetY, coors.z-offsetZ)
    }

    fun getClusterCubeCoordinatesById(i: UInt): ClusterCubeCoordinates {
        return ClusterCubeCoordinates(i%16u + offsetX, (i/16u)%16u + offsetY, i/(16u*16u) + offsetZ)
    }
}
