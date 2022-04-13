package silver.ore.app.utils

data class ChunkCubeCoordinates(val x: Int, val y: Int, val z: Int) {
    init {
        if (x <= -16 || x >= 16) {
            throw IllegalArgumentException("invalid x: $x")
        }
        if (y <= -16 || y >= 16) {
            throw IllegalArgumentException("invalid y: $y")
        }
        if (z <= -16 || z >= 16) {
            throw IllegalArgumentException("invalid z: $z")
        }
    }

    fun getCubeId(): Int {
        val x = (32+this.x)%16
        val y = (32+this.y)%16
        val z = (32+this.z)%16
        return x+y*16+z*16*16
    }
}
