package silver.ore.core.world.generator

import silver.ore.core.world.ClusterGenerator
import silver.ore.core.world.Cube
import silver.ore.core.world.Generator
import silver.ore.core.game.Material
import silver.ore.core.world.utils.GlobalCubeCoordinates

class Flat(val generator: Generator) : ClusterGenerator() {
    override fun getCube(coors: GlobalCubeCoordinates): Cube {
        val floor: Material
        var wall: Material = Material.AIR
        if (coors.z == 128L) {
            floor = Material.GRASS
        } else if (coors.z <= 124L) {
            @Suppress("NAME_SHADOWING") val cube = generator.oreGenerator.getCube(coors)
            if (cube != null) {
                return cube
            }
            wall = Material.STONE
            floor = Material.STONE
        } else if (coors.z > 128L) {
            wall = Material.AIR
            floor = Material.AIR
        } else {
            wall = Material.SOIL
            floor = Material.SOIL
        }
        return Cube(wall, floor)
    }
}
