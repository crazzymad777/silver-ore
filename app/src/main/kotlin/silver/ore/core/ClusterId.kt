package silver.ore.core

data class ClusterId(var x: Long, var y: Long) {
    override fun toString(): String {
        val half = 72057594037927935/2

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

    fun getNeighbourhood(): Array<ClusterId> {
        return arrayOf(ClusterId(x, y-1),
                       ClusterId(x+1, y-1),
                       ClusterId(x+1, y),
                       ClusterId(x+1, y+1),
                       ClusterId(x, y+1),
                       ClusterId(x-1, y+1),
                       ClusterId(x-1, y),
                       ClusterId(x-1, y-1))
    }
}
