package silver.ore.app

data class ClusterId(val x: Int, val y: Int) {
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
