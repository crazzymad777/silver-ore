package silver.ore.app.generator

import silver.ore.app.ClusterGenerator
import silver.ore.app.Cube
import silver.ore.app.Generator
import silver.ore.app.Material
import silver.ore.app.utils.GlobalCubeCoordinates

class Flat(val generator: Generator) : ClusterGenerator() {
    override fun getCube(coors: GlobalCubeCoordinates): Cube {
        val floor: Material
        var wall: Material = Material.AIR
        if (coors.z == 128) {
            floor = Material.GRASS
        } else if (coors.z <= 124) {
            @Suppress("NAME_SHADOWING") val cube = generator.oreGenerator.getCube(coors)
            if (cube != null) {
                return cube
            }
            wall = Material.STONE
            floor = Material.STONE
        } else if (coors.z > 128) {
            wall = Material.AIR
            floor = Material.AIR
        } else {
            wall = Material.SOIL
            floor = Material.SOIL
        }
        return Cube(wall, floor)
    }
}
