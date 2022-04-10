package silver.ore.app.generator

import silver.ore.app.AbstractGenerator
import silver.ore.app.Cube
import kotlin.random.Random

class HumanTown(random: Random = Random(0)) : AbstractGenerator(random) {
    private val buildingGenerator = BuildingGenerator(random)
    override fun getCube(x: Int, y: Int, z: Int): Cube? {
        return buildingGenerator.getCube(x, y, z)
    }
}
