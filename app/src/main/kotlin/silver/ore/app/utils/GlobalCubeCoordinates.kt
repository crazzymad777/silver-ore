package silver.ore.app.utils

// relative to world
data class GlobalCubeCoordinates(val x: Int, val y: Int, val z: Int)
{
    fun getChunkCoordinates(): WorldChunkCoordinates {
//        var x = this.x
//        if (x < 0) {
//            x = 16 - x
//            x *= -1
//        }
//        var y = this.y
//        if (y < 0) {
//            y = 16 - y
//            y *= -1
//        }
        var x = this.x
        if (x < 0) {
            x -= 16
        }
        var y = this.y
        if (y < 0) {
            y -= 16
        }
        return WorldChunkCoordinates(x/16, y/16, z/16)
    }
}
