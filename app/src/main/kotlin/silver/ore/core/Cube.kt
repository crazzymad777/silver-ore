package silver.ore.core

import silver.ore.core.game.Furniture
import silver.ore.core.game.Item
import silver.ore.core.game.Ore
import silver.ore.core.generator.Building

class Cube(private val wall: Material = Material.AIR, private val floor: Material = Material.AIR, private val building: Building? = null, private val furniture: Furniture? = null, private val ore: Ore? = null) {
    fun getItem(): Item? {
        if (ore == null) {
            if (furniture == null) {
                return null
            }
            return furniture
        }
        return ore
    }

    fun display(): Char {
        val item = getItem()
        if (item == null) {
            if (wall == Material.AIR) {
                if (floor == Material.GRASS) {
                    return ','
                } else if (floor == Material.WOOD) {
                    return '_'
                }
                return floor.display()
            }
            if (wall == Material.WOOD) {
                return '+'
            }
            return wall.display()
        }
        return item.display()
    }

    fun fullDisplay(): String {
        return "$wall:$floor:$building"
    }

    fun displayTest(): String {
        return "$wall:$floor"
    }
}
