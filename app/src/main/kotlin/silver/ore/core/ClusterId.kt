package silver.ore.core

data class ClusterId(var x: Long, var y: Long) {
    override fun toString(): String {
        val half = maxClusterId/2

        // Show signed clusterId
        val x = if (x < half) {
            this.x
        } else {
            (-this.x+half*2)*-1-2
        }

        val y = if (y < half) {
            this.y
        } else {
            (-this.y+half*2)*-1-2
        }

        return "ClusterId(x=$x, y=$y)"
    }

    companion object {
        const val maxClusterId = 72057594037927935

        fun signedClusterId(x: Long, y: Long): ClusterId {
            val half = maxClusterId

            val unsignedX = if (x < 0) {
                maxClusterId+x+1
            } else if (x < maxClusterId/2) {
                x
            } else {
                (-x+half*2)*-1-2
            }

            val unsignedY = if (y < 0) {
                maxClusterId+y+1
            } else if (y < maxClusterId/2) {
                y
            } else {
                (-y+half*2)*-1-2
            }

            return ClusterId(unsignedX, unsignedY)
        }
    }

    fun getNeighbourhood(): Array<ClusterId> {
        return arrayOf(signedClusterId(x, y-1),
            signedClusterId(x+1, y-1),
            signedClusterId(x+1, y),
            signedClusterId(x+1, y+1),
            signedClusterId(x, y+1),
            signedClusterId(x-1, y+1),
            signedClusterId(x-1, y),
            signedClusterId(x-1, y-1))
    }
}
