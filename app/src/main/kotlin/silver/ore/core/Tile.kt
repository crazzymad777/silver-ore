package silver.ore.core

data class Tile(val clusterId: ClusterId, val type: TYPE)
{
    // add isLand & isSea methods
    enum class TYPE {
        TOWN,
        FLAT,
        SEA;
        fun isSea(): Boolean {
            if (this == SEA) {
                return true
            }
            return false
        }
    }
}
