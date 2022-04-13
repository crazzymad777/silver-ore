package silver.ore.app

import kotlin.random.Random

class Map(val random: Random) {
    private val width = 16
    private val height = 16
    private val tiles = HashMap<ClusterId, Tile>()
    val humanTownClusterId: ClusterId

    init {
        val x = random.nextInt(0, width)
        val y = random.nextInt(0, height)
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

    fun getTileType(clusterId: ClusterId): Tile.TYPE {
        val tile = tiles[clusterId] ?: return Tile.TYPE.SEA
        return tile.type
    }

    fun getTile(clusterId: ClusterId, type: Tile.TYPE = Tile.TYPE.SEA): Tile {
        var tile = tiles[clusterId]
        if (tile != null) {
            return tile
        }
        tile = Tile(clusterId, type)
        tiles[clusterId] = tile
        return tile
    }
}
