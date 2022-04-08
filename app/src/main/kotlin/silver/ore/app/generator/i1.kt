package silver.ore.app.generator

import silver.ore.app.Cube
import silver.ore.app.Generator
import silver.ore.app.Material
import kotlin.random.Random

class i1(random: Random = Random(0)) : Generator(random) {
    val buildings = Array(random.nextInt()%16+8) { Building(random) }
    override fun getCube(x: Int, y: Int, z: Int): Cube {
        val floor: Material
        var wall: Material = Material.AIR

        var building: Building? = null
        for (build in buildings) {
            if (build.check(x, y, z)) {
                building = build
                break
            }
        }

        if (z == 128) {
            if (building != null) {
                floor = Material.WOOD
                if (building.isWall(x, y, z)) {
                    wall = Material.WOOD
                }
            } else {
                floor = Material.GRASS
            }
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
