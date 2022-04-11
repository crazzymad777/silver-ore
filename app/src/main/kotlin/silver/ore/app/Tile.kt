package silver.ore.app

data class Tile(val clusterId: ClusterId, val type: TYPE)
{
    enum class TYPE {
        TOWN,
        FLAT,
        SEA
    }
}
