package silver.ore.app.generator

import silver.ore.app.Cube
import silver.ore.app.Material
import silver.ore.app.game.Furniture
import kotlin.random.Random
import kotlin.random.nextUInt

class BuildingGenerator(random: Random = Random(0)) {
    private val buildings = Array((random.nextUInt()%32u).toInt()+32) { Building(random) }
    init {
        // TODO: detect intersecting
    }
    fun getCube(x: Int, y: Int, z: Int): Cube? {
        var building: Building? = null
        for (build in buildings) {
            if (build.check(x, y, z)) {
                building = build
                break
            }
        }

        if (building != null) {
            val furniture: Furniture? = building.getFurniture(x, y, z)
            val wall = building.getWall(x, y, z)
            return Cube(wall, Material.WOOD, building, furniture)
        }

        return null
    }
}
