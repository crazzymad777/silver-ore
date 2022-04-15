package silver.ore.core.generator

import silver.ore.core.*
import silver.ore.core.utils.GlobalCubeCoordinates
import silver.ore.core.utils.Seed
import kotlin.random.Random

class i1(private val seed: Long, clusterId: ClusterId, val generator: Generator) : ClusterGenerator() {
    val random: Random
    init {
        val seed = Seed.make("${this.seed}:i1:${clusterId.getSignedX()}:${clusterId.getSignedY()}")
        random = Random(seed)
    }

    private val humanTown = HumanTown(random)
    override fun getCube(coors: GlobalCubeCoordinates): Cube {
        val floor: Material
        var wall: Material = Material.AIR

        val cube = humanTown.getCube(coors)
        if (cube != null) {
            return cube
        }

        if (coors.z == 128L) {
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
