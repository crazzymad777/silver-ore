package silver.ore.app.utils

// relative to world
data class GlobalCubeCoordinates(val x: Int, val y: Int, val z: Int)
{
    fun getChunkCoordinates(): WorldChunkCoordinates {
        return WorldChunkCoordinates(x/16, y/16, z/16)
    }
}
