package silver.ore.app.generator

import silver.ore.app.AbstractGenerator
import silver.ore.app.Cube
import silver.ore.app.utils.GlobalCubeCoordinates
import kotlin.random.Random

class HumanTown(random: Random = Random(0)) : AbstractGenerator(random) {
    private val buildingGenerator = BuildingGenerator(random)
    override fun getCube(coors: GlobalCubeCoordinates): Cube? {
        return buildingGenerator.getCube(coors.x, coors.y, coors.z)
    }
}
