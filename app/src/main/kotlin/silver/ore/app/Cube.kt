package silver.ore.app

class Cube(private val wall: Material = Material.AIR, private val floor: Material = Material.AIR) {
    fun display(): String {
        return "$wall:$floor"
    }
}
