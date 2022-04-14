package silver.ore.core.generator

import silver.ore.core.AbstractGenerator
import silver.ore.core.Cube
import silver.ore.core.utils.GlobalCubeCoordinates
import kotlin.random.Random

class HumanTown(random: Random = Random(0)) : AbstractGenerator() {
    private val buildingGenerator = BuildingGenerator(random)
    override fun getCube(coors: GlobalCubeCoordinates): Cube? {
        return buildingGenerator.getCube(coors.x.toUInt() % 256u, coors.y.toUInt() % 256u, coors.z.toUInt() % 256u)
    }
}
