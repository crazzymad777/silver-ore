package silver.ore.core

data class ClusterId(var x: Long, var y: Long) {
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
