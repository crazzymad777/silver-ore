package silver.ore.core.utils

// relative to world
data class GlobalCubeCoordinates(val x: Long, val y: Long, val z: Long)
{
    companion object {
        fun fromInternalCoordinates(x: ULong, y: ULong, z: ULong): GlobalCubeCoordinates {
            return GlobalCubeCoordinates(x.toLong(), y.toLong(), z.toLong())
        }
    }

    fun getChunkCoordinates(): WorldChunkCoordinates {
        return WorldChunkCoordinates(x.toULong()/16u, y.toULong()/16u, z.toULong()/16u)
    }
}
