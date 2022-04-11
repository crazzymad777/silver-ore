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

    fun getTile(clusterId: ClusterId): Tile {
        var tile = tiles[clusterId]
        if (tile != null) {
            return tile
        }
        tile = Tile(clusterId, Tile.TYPE.FLAT)
        tiles[clusterId] = tile
        return tile
    }
}
