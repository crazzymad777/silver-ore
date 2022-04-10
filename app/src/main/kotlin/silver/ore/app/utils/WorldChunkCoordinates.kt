package silver.ore.app.utils

// relative obviously to world. x+1 next chunk on x-axis.
data class WorldChunkCoordinates(val x: Int, val y: Int, val z: Int) {
    fun getClusterChunkCoordinates(): ClusterChunkCoordinates {
        return ClusterChunkCoordinates(x%16, y%16, z%16)
    }
}
