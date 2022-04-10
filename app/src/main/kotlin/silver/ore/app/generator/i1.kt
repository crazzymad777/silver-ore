package silver.ore.app.generator

import silver.ore.app.Cube
import silver.ore.app.Material
import silver.ore.app.WorldGenerator
import kotlin.random.Random

class i1(random: Random = Random(0)) : WorldGenerator(random) {
    private val humanTown = HumanTown(random)
    override fun getCube(x: Int, y: Int, z: Int): Cube {
        val floor: Material
        var wall: Material = Material.AIR

        val cube = humanTown.getCube(x, y, z)
        if (cube != null) {
            return cube
        }

        if (z == 128) {
            floor = Material.GRASS
        } else if (z <= 124) {
            @Suppress("NAME_SHADOWING") val cube = oreGenerator.getCube(x, y, z)
            if (cube != null) {
                return cube
            }
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
