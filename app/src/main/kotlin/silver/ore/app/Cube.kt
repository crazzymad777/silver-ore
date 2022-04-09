package silver.ore.app

import silver.ore.app.generator.Building

class Cube(private val wall: Material = Material.AIR, private val floor: Material = Material.AIR, private val building: Building? = null) {
    fun display(): Char {
        if (wall == Material.AIR) {
            if (floor == Material.GRASS) {
                return ','
            }
            return floor.display()
        }
        if (wall == Material.WOOD) {
            return '+'
        }
        return wall.display()
    }
    fun fullDisplay(): String {
        return "$wall:$floor:$building"
    }
    fun displayTest(): String {
        return "$wall:$floor"
    }
}
