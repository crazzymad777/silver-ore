package silver.ore.app.generator

import silver.ore.app.Material
import silver.ore.app.game.Furniture
import silver.ore.app.game.furniture.*
import kotlin.math.abs
import kotlin.random.Random
import kotlin.random.nextUInt

class Building(random: Random) {
    private val x: Int = (random.nextUInt()%256u).toInt()
    private val y: Int = (random.nextUInt()%256u).toInt()
    private val z: Int = 128
    private val width: Int = (random.nextUInt()%4u).toInt()+4
    private val height: Int = (random.nextUInt()%4u).toInt()+4
    private val basement: Boolean = random.nextBoolean()
    private val loft: Boolean = random.nextBoolean()
    fun hasBasement(): Boolean { return basement }
    fun hasLoft(): Boolean { return loft }
    private val cornersX =  arrayOf( x-width+1, x+width-1)
    private val cornersY =  arrayOf( y-height+1, y+height-1)
    val stairsX: Int = cornersX[random.nextInt(0, 2)]
    val stairsY: Int = cornersY[random.nextInt(0, 2)]

    val tableX: Int = random.nextInt(x-width+1, x+width)
    val tableY: Int = random.nextInt(y-height+1, y+height)

    val chestX: Int = random.nextInt(x-width+1, x+width)
    val chestY: Int = random.nextInt(y-height+1, y+height)

    val closetX: Int = random.nextInt(x-width+1, x+width)
    val closetY: Int = random.nextInt(y-height+1, y+height)

    val bedX: Int = random.nextInt(x-width+1, x+width)
    val bedY: Int = random.nextInt(y-height+1, y+height)

    var chairX: Int
    var chairY: Int

    init {
        val xes = arrayOf(tableX-1, tableX+1)
        val yes = arrayOf(tableY-1, tableY+1)
        do {
            chairX = xes[random.nextInt(0, 2)]
            chairY = yes[random.nextInt(0, 2)]
        } while (isWall(chairX, chairY, z))
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
        if (abs(this.x-x) == width || abs(this.y-y) == height) {
            if (z == this.z || (z == this.z+1 && this.loft) || (z == this.z-1 && this.basement)) {
                return true;
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

        if (this.z == z) {
            if (bedX == x && bedY == y) {
                return Bed()
            }
            if (tableX == x && tableY == y) {
                return Table()
            }
            if (chestX == x && chestY == y) {
                return Chest()
            }
            if (closetX == x && closetY == y) {
                return Closet()
            }
            if (chairX == x && chairY == y) {
                return Chair()
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
