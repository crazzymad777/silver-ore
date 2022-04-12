package silver.ore.app

data class Tile(val clusterId: ClusterId, val type: TYPE)
{
    // add isLand & isSea methods
    enum class TYPE {
        TOWN,
        FLAT,
        SEA
    }
}
