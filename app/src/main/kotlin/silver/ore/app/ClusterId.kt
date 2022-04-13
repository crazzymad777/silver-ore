package silver.ore.app

data class ClusterId(var x: Int, var y: Int) {
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
