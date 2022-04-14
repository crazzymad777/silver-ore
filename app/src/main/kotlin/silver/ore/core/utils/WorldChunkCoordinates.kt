package silver.ore.core.utils

import silver.ore.core.ClusterId

// relative obviously to world. x+1 next chunk on x-axis.
data class WorldChunkCoordinates(var x: ULong, var y: ULong, val z: ULong) {
    fun getClusterChunkCoordinates(): ClusterChunkCoordinates {
        return ClusterChunkCoordinates((x%16u).toUInt(), (y%16u).toUInt(), (z%16u).toUInt())
    }

    fun getClusterId(): ClusterId {
        return ClusterId((x/16u).toLong(), (y/16u).toLong())
    }
}
