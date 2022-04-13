package silver.ore.core.utils

data class ChunkTransformer(val chunkId: Int) {
    init {
        if (chunkId < 0 || chunkId >= 4096) {
            throw IllegalArgumentException("invalid chunkId: $chunkId")
        }
    }

    private val offsetX = (chunkId%16)*16
    private val offsetY = ((chunkId/16)%16)*16
    private val offsetZ = (chunkId/(16*16))*16

    fun makeGlobalCubeCoordinates(coors: ChunkCubeCoordinates): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(coors.x+offsetX, coors.y+offsetY, coors.z+offsetZ)
    }

    fun getLocalCubeCoordinates(coors: ClusterCubeCoordinates): ChunkCubeCoordinates {
        return ChunkCubeCoordinates((coors.x-offsetX)%16, (coors.y-offsetY)%16, coors.z-offsetZ)
    }

    fun getGlobalCubeCoordinatesById(i: Int): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(i%16 + offsetX, (i/16)%16 + offsetY, i/(16*16) + offsetZ)
    }
}
