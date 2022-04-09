package silver.ore.app

class Cube(private val wall: Material = Material.AIR, private val floor: Material = Material.AIR) {
    fun display(): String {
//        return "$wall:$floor"
        if (wall == Material.WOOD) {
            return "w"
        } else if (wall.isSolid()) {
            return "s"
        }
        return "_"
    }
}
