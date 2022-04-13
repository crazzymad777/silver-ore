package silver.ore.core.generator

import silver.ore.core.Material
import silver.ore.core.game.Furniture
import silver.ore.core.game.furniture.*
import java.util.*
import kotlin.math.abs
import kotlin.random.Random
import kotlin.random.nextUInt

class Building(val random: Random) {
    var ignored: Boolean = false
    val x: Int = (random.nextUInt()%256u).toInt()
    val y: Int = (random.nextUInt()%256u).toInt()
    val z: Int = 128
    val width: Int = (random.nextUInt()%4u).toInt()+4
    val height: Int = (random.nextUInt()%4u).toInt()+4

    private val basement: Boolean = random.nextBoolean()
    private val loft: Boolean = random.nextBoolean()
    fun hasBasement(): Boolean { return basement }
    fun hasLoft(): Boolean { return loft }
    private val cornersX =  arrayOf( x-width+1, x+width-1)
    private val cornersY =  arrayOf( y-height+1, y+height-1)
    val stairsX: Int = cornersX[random.nextInt(0, 2)]
    val stairsY: Int = cornersY[random.nextInt(0, 2)]

    data class DataFurniture(val x: Int, val y: Int, val z: Int, val furniture: String = "null")
    private val furniture: Vector<DataFurniture> = Vector()
    init {
        furniture.addElement(DataFurniture(stairsX, stairsY, z, "Stairs"))
        if (this.hasLoft()) {
            furniture.addElement(DataFurniture(stairsX, stairsY, z + 1, "Stairs"))
        }
        if (this.hasBasement()) {
            furniture.addElement(DataFurniture(stairsX, stairsY, z - 1, "Stairs"))
        }
    }

    fun newFurniture(type: String): DataFurniture? {
        var i = 0
        var x: Int
        var y: Int
        var z: Int
        do {
            x = random.nextInt(this.x-width+1, this.x+width)
            y = random.nextInt(this.y-height+1, this.y+height)
            var minZ = this.z
            if (hasBasement()) {
                minZ = this.z-1
            }
            var maxZ = this.z+1
            if (hasLoft()) {
                maxZ = this.z+1+1
            }
            z = random.nextInt(minZ, maxZ)

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
        val coors = arrayOf(Pair(follow.x-1, follow.y),
                            Pair(follow.x+1, follow.y),
                            Pair(follow.x, follow.y+1),
                            Pair(follow.x, follow.y-1))

        val offset = random.nextInt(0, 4)
        var pair: Pair<Int, Int>? = null

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
        val x: Int
        val y: Int
        if (random.nextBoolean()) {
            x = random.nextInt(this.x-width+1, this.x+width)
            y = if (random.nextBoolean()) {
                this.y-height
            } else {
                this.y+height
            }
        } else {
            y = random.nextInt(this.y-height+1, this.y+height)
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

    fun check(x: Int, y: Int, z: Int): Boolean {
        if (abs(this.x-x) <= width && abs(this.y-y) <= height) {
            if (z == this.z || (z == this.z+1 && this.loft) || (z == this.z-1 && this.basement)) {
                return true;
            }
        }
        return false;
    }

    fun isWall(x: Int, y: Int, z: Int): Boolean {
        if (doorData.x != x || doorData.y != y || doorData.z != z) {
            if (abs(this.x - x) == width || abs(this.y - y) == height) {
                if (z == this.z || (z == this.z + 1 && this.loft) || (z == this.z - 1 && this.basement)) {
                    return true;
                }
            }
        }
        return false;
    }

    override fun toString(): String {
        return "building:$x:$y:$z:width:$width;height:$height;basement:$basement;loft:$loft;"
    }

    fun getFurniture(x: Int, y: Int, z: Int): Furniture? {
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

    fun getWall(x: Int, y: Int, z: Int): Material {
        if (this.isWall(x, y, z)) {
            return Material.WOOD
        }
        return Material.AIR
    }
}
