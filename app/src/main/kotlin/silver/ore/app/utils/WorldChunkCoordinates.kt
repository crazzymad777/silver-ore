package silver.ore.app.utils

import silver.ore.app.ClusterId

// relative obviously to world. x+1 next chunk on x-axis.
data class WorldChunkCoordinates(var x: Int, var y: Int, val z: Int) {
    fun getClusterChunkCoordinates(): ClusterChunkCoordinates {
        val x = (16+this.x)%16
        val y = (16+this.y)%16
        return ClusterChunkCoordinates(x%16, y%16, z%16)
    }

    fun getClusterId(): ClusterId {
        var x = this.x
        if (x < 0) {
            x -= 16
        }
        var y = this.y
        if (y < 0) {
            y -= 16
        }
        return ClusterId(x/16, y/16)
    }
}
