package silver.ore.app.utils

data class ClusterChunkCoordinates(val x: Int, val y: Int, val z: Int) {
    init {
        if (x < 0 || x >= 16) {
            throw IllegalArgumentException("invalid x: $x")
        }
        if (y < 0 || y >= 16) {
            throw IllegalArgumentException("invalid y: $y")
        }
        if (z < 0 || z >= 16) {
            throw IllegalArgumentException("invalid z: $z")
        }
    }

    fun getChunkId(): Int {
        return x+y*16+z*16*16
    }
}
