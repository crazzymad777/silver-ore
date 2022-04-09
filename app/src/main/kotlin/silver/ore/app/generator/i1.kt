package silver.ore.app.generator

import silver.ore.app.Cube
import silver.ore.app.Generator
import silver.ore.app.Material
import kotlin.random.Random

class i1(random: Random = Random(0)) : Generator(random) {
    private val buildingGenerator = BuildingGenerator(random)
    override fun getCube(x: Int, y: Int, z: Int): Cube {
        val floor: Material
        var wall: Material = Material.AIR

        val cube = buildingGenerator.getCube(x, y, z)
        if (cube != null) {
            return cube
        }

        if (z == 128) {
            floor = Material.GRASS
        } else if (z <= 124) {
            wall = Material.STONE
            floor = Material.STONE
        } else if (z > 128) {
            wall = Material.AIR
            floor = Material.AIR
        } else {
            wall = Material.SOIL
            floor = Material.SOIL
        }
        return Cube(wall, floor)
    }
}
