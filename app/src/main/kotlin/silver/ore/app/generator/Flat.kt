package silver.ore.app.generator

import silver.ore.app.Cube
import silver.ore.app.Material
import silver.ore.app.WorldGenerator
import kotlin.random.Random

class Flat(random: Random = Random(0)) : WorldGenerator(random) {
    override fun getCube(x: Int, y: Int, z: Int): Cube {
        val floor: Material
        var wall: Material = Material.AIR
        if (z == 128) {
            floor = Material.GRASS;
        } else if (z <= 124) {
            wall = Material.STONE;
            floor = Material.STONE;
        } else if (z > 128) {
            wall = Material.AIR;
            floor = Material.AIR;
        } else {
            wall = Material.SOIL;
            floor = Material.SOIL;
        }
        return Cube(wall, floor);
    }
}
