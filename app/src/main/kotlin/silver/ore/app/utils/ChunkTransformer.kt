package silver.ore.app.utils

data class ChunkTransformer(val chunkId: Int) {
    private val offsetX = (chunkId%16)*16
    private val offsetY = ((chunkId/16)%16)*16
    private val offsetZ = (chunkId/(16*16))*16

    fun makeGlobalCubeCoordinates(coors: ChunkCubeCoordinates): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(coors.x+offsetX, coors.y+offsetY, coors.z+offsetZ)
    }

    fun getLocalCubeCoordinates(coors: GlobalCubeCoordinates): ChunkCubeCoordinates {
        return ChunkCubeCoordinates(coors.x-offsetX, coors.y-offsetY, coors.z-offsetZ)
    }

    fun getGlobalCubeCoordinatesById(i: Int): GlobalCubeCoordinates {
        return GlobalCubeCoordinates(i%16 + offsetX, (i/16)%16 + offsetY, i/(16*16) + offsetZ)
    }
}
