package silver.ore.core

import silver.ore.core.utils.Seed
import kotlin.random.Random

class Map(val seed: Long) {
    private val tiles = HashMap<ClusterId, Tile>()
    val defaultClusterId: ClusterId

    init {
        var tile: Tile
        var i = 0L
        var x = 0L
        var y = 0L

        val k = 16
        while (true) {
            val clusterId = ClusterId(x+i*k, y+i*k)
            tile = getTile(clusterId)

            if (tile.type == Tile.TYPE.TOWN) {
                defaultClusterId = clusterId
                break
            }

            x++
            if (x >= i*k) {
                y++
                x = 0
                if (y >= i*k) {
                    y = 0
                    i++
                }
            }
        }
    }

    fun getTileType(clusterId: ClusterId): Tile.TYPE {
        return getTile(clusterId).type
    }

    fun getTile(clusterId: ClusterId): Tile {
        var tile = tiles[clusterId]
        if (tile != null) {
            return tile
        }

        val seed = Seed.make("${this.seed}:map_tile:${clusterId.getSignedX()}:${clusterId.getSignedY()}")
        val random = Random(seed)
        val p = random.nextDouble(0.0, 1.0)

        val type: Tile.TYPE = if (p < 0.05) {
            Tile.TYPE.TOWN
        } else if (p < 0.25) {
            Tile.TYPE.SEA
        } else {
            Tile.TYPE.FLAT
        }

        tile = Tile(clusterId, type)
        tiles[clusterId] = tile
        return tile
    }
}
