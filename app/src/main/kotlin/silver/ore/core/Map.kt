package silver.ore.core

import kotlin.random.Random

class Map(val random: Random) {
    private val width = 16L
    private val height = 16L
    private val tiles = HashMap<ClusterId, Tile>()
    val humanTownClusterId: ClusterId

    init {
        val x = random.nextLong(0, width)
        val y = random.nextLong(0, height)
        humanTownClusterId = ClusterId(x, y)
        tiles[humanTownClusterId] = Tile(humanTownClusterId, Tile.TYPE.TOWN)
    }

    init {
        for (x in 0 until width) {
            for (y in 0 until height) {
                val id = ClusterId(x, y)
                if (id != humanTownClusterId) {
                    var type = Tile.TYPE.FLAT
                    if (random.nextBoolean() && random.nextBoolean()) {
                        type = Tile.TYPE.SEA
                    }
                    getTile(id, type)
                }
            }
        }
    }

    private fun defaultType(clusterId: ClusterId) : Tile.TYPE{
        return Tile.TYPE.SEA
    }

    fun getTileType(clusterId: ClusterId): Tile.TYPE {
        val tile = tiles[clusterId] ?: return defaultType(clusterId)
        return tile.type
    }

    fun getTile(clusterId: ClusterId, type: Tile.TYPE = defaultType(clusterId)): Tile {
        var tile = tiles[clusterId]
        if (tile != null) {
            return tile
        }
        tile = Tile(clusterId, type)
        tiles[clusterId] = tile
        return tile
    }
}
