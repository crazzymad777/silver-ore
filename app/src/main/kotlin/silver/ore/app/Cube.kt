package silver.ore.app

import silver.ore.app.game.Furniture
import silver.ore.app.generator.Building

class Cube(private val wall: Material = Material.AIR, private val floor: Material = Material.AIR, private val building: Building? = null, private val furniture: Furniture? = null) {
    fun display(): Char {
        if (furniture == null) {
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
        return furniture.display()
    }
    fun fullDisplay(): String {
        return "$wall:$floor:$building"
    }
    fun displayTest(): String {
        return "$wall:$floor"
    }
}
