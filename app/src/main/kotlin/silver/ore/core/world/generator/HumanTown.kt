package silver.ore.core.world.generator

import silver.ore.core.world.AbstractGenerator
import silver.ore.core.world.Cube
import silver.ore.core.world.utils.GlobalCubeCoordinates
import kotlin.random.Random

class HumanTown(random: Random = Random(0)) : AbstractGenerator() {
    private val buildingGenerator = BuildingGenerator(random)
    override fun getCube(coors: GlobalCubeCoordinates): Cube? {
        return buildingGenerator.getCube((coors.x % 256).toInt(), (coors.y % 256).toInt(), (coors.z % 256).toInt())
    }
}
