package silver.ore.core.utils

data class ClusterChunkCoordinates(val x: UInt, val y: UInt, val z: UInt) {
    init {
        if (x >= 16u) {
            throw IllegalArgumentException("invalid x: $x")
        }
        if (y >= 16u) {
            throw IllegalArgumentException("invalid y: $y")
        }
        if (z >= 16u) {
            throw IllegalArgumentException("invalid z: $z")
        }
    }

    fun getChunkId(): UInt {
        return x+y*16u+z*16u*16u
    }
}
