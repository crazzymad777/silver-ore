package silver.ore.core.generator

import silver.ore.core.Cube
import silver.ore.core.Material
import silver.ore.core.game.Furniture
import java.util.*
import kotlin.math.max
import kotlin.random.Random
import kotlin.random.nextUInt

class BuildingGenerator(random: Random = Random(0)) {
    private val generatedBuildings = Array((random.nextUInt()%64u).toInt()+32) { Building(random) }
    private val buildings = Vector<Building>()
    init {
        for (building in generatedBuildings) {
            var addBuilding = true

            if (building.ignored) {
                addBuilding = false
            } else {
                for (otherBuilding in generatedBuildings) {
                    if (!otherBuilding.ignored) {
                        if (building != otherBuilding) {
                            val disX = building.x-otherBuilding.x
                            val limitX = max(building.width + 1u, otherBuilding.x + 1u)
                            if (disX < limitX) {
                                val disY = building.y-otherBuilding.y
                                val limitY = max(building.height + 1u, otherBuilding.height + 1u)
                                if (disY < limitY) {
                                    addBuilding = false
                                    building.ignored = true
                                    break
                                }
                            }
                        }
                    }
                }
            }

            if (addBuilding) {
                buildings.add(building)
            }
        }
    }
    fun getCube(x: UInt, y: UInt, z: UInt): Cube? {
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
