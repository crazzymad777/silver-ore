package silver.ore.app.generator

import silver.ore.app.Cube
import silver.ore.app.Material
import silver.ore.app.game.Furniture
import java.util.*
import kotlin.math.abs
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
                            val disX = abs(building.x-otherBuilding.x)
                            val limitX = max(building.width + 1, otherBuilding.x + 1)
                            if (disX < limitX) {
                                val disY = abs(building.y-otherBuilding.y)
                                val limitY = max(building.height + 1, otherBuilding.height + 1)
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
