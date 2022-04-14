package silver.ore.core.generator

import silver.ore.core.Material
import silver.ore.core.game.Furniture
import silver.ore.core.game.furniture.*
import java.util.*
import kotlin.random.Random
import kotlin.random.nextUInt

class Building(val random: Random) {
    var ignored: Boolean = false
    val x = random.nextUInt()%256u
    val y = random.nextUInt()%256u
    val z = 128u
    val width = random.nextUInt()%4u+4u
    val height = random.nextUInt()%4u+4u

    private val basement: Boolean = random.nextBoolean()
    private val loft: Boolean = random.nextBoolean()
    private fun hasBasement(): Boolean { return basement }
    private fun hasLoft(): Boolean { return loft }
    private val cornersX =  arrayOf( x-width+1u, x+width-1u)
    private val cornersY =  arrayOf( y-height+1u, y+height-1u)
    private val stairsX: UInt = cornersX[random.nextInt(0, 2)]
    private val stairsY: UInt = cornersY[random.nextInt(0, 2)]

    data class DataFurniture(val x: UInt, val y: UInt, val z: UInt, val furniture: String = "null")
    private val furniture: Vector<DataFurniture> = Vector()
    init {
        furniture.addElement(DataFurniture(stairsX, stairsY, z, "Stairs"))
        if (this.hasLoft()) {
            furniture.addElement(DataFurniture(stairsX, stairsY, z + 1u, "Stairs"))
        }
        if (this.hasBasement()) {
            furniture.addElement(DataFurniture(stairsX, stairsY, z - 1u, "Stairs"))
        }
    }

    fun newFurniture(type: String): DataFurniture? {
        var i = 0
        var x: UInt
        var y: UInt
        var z: UInt
        do {
            // this.x-width+1u
            x = random.nextUInt(0u, this.x+width)
            // this.y-height+1u
            y = random.nextUInt(0u, this.y+height)
            var minZ = this.z
            if (hasBasement()) {
                minZ = this.z-1u
            }
            var maxZ = this.z+1u
            if (hasLoft()) {
                maxZ = this.z+1u+1u
            }
            z = random.nextUInt(minZ, maxZ)

            var collision = false
            for (element in furniture) {
                if (element.x == x && element.y == y && element.z == z) {
                    collision = true
                }
            }

            if (!collision) {
                val data = DataFurniture(x, y, z, type)
                furniture.addElement(data)
                return data
            }
            i++
        } while(i < 10)

        return null
    }

    // Supposed that chair generated right after table generation. So collision not checked.
    fun newChair(type: String, follow: DataFurniture): DataFurniture? {
        val coors = arrayOf(Pair(follow.x-1u, follow.y),
                            Pair(follow.x+1u, follow.y),
                            Pair(follow.x, follow.y+1u),
                            Pair(follow.x, follow.y-1u))

        val offset = random.nextInt(0, 4)
        var pair: Pair<UInt, UInt>? = null

        for (i in 0..3) {
            val x = coors[(offset+i)%4].first
            val y = coors[(offset+i)%4].second
            if (!isWall(x, y, z)) {
                pair = coors[(offset+i)%4]
                break
            }
        }

        if (pair != null) {
            val x = pair.first
            val y = pair.second
            val z = follow.z
            val data = DataFurniture(x, y, z, type)
            furniture.addElement(data)
            return data
        }

        return null
    }

    fun newDoor(): DataFurniture {
        val x: UInt
        val y: UInt
        if (random.nextBoolean()) {
            // this.x-width+1u
            x = random.nextUInt(0u, this.x+width)
            y = if (random.nextBoolean()) {
                this.y-height
            } else {
                this.y+height
            }
        } else {
            // this.y-height+1u
            y = random.nextUInt(0u, this.y+height)
            x = if (random.nextBoolean()) {
                this.x-width
            } else {
                this.x+width
            }
        }
        val data = DataFurniture(x, y, z, "Door")
        furniture.addElement(data)
        return data
    }

    private val doorData: DataFurniture = newDoor()
    init {
        val table = newFurniture("Table")
        if (table != null) {
            newChair("Chair", table)
        }

        newFurniture("Chest")
        newFurniture("Closet")
        newFurniture("Bed")
    }

    fun check(x: UInt, y: UInt, z: UInt): Boolean {
        if (this.x-x <= width && this.y-y <= height) {
            if (z == this.z || (z == this.z+1u && this.loft) || (z == this.z-1u && this.basement)) {
                return true;
            }
        }
        return false;
    }

    fun isWall(x: UInt, y: UInt, z: UInt): Boolean {
        if (doorData.x != x || doorData.y != y || doorData.z != z) {
            if (this.x - x == width || this.y - y == height) {
                if (z == this.z || (z == this.z + 1u && this.loft) || (z == this.z - 1u && this.basement)) {
                    return true
                }
            }
        }
        return false;
    }

    override fun toString(): String {
        return "building:$x:$y:$z:width:$width;height:$height;basement:$basement;loft:$loft;"
    }

    fun getFurniture(x: UInt, y: UInt, z: UInt): Furniture? {
        if (this.stairsX == x && this.stairsY == y && (this.hasLoft() || this.hasBasement())) {
            return Stairs()
        }

        for (element in furniture) {
            if (x == element.x && y == element.y && z == element.z) {
                when (element.furniture) {
                    "Stairs" -> {
                        return Stairs()
                    }
                    "Table" -> {
                        return Table()
                    }
                    "Chair" -> {
                        return Chair()
                    }
                    "Bed" -> {
                        return Bed()
                    }
                    "Closet" -> {
                        return Closet()
                    }
                    "Chest" -> {
                        return Chest()
                    }
                    "Door" -> {
                        return Door()
                    }
                }
            }
        }

        return null
    }

    fun getWall(x: UInt, y: UInt, z: UInt): Material {
        if (this.isWall(x, y, z)) {
            return Material.WOOD
        }
        return Material.AIR
    }
}
