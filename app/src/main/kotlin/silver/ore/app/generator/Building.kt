package silver.ore.app.generator

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
    fun hasBasement() { basement }
    fun hasLoft() { loft }
    // TODO: randomize stair_x & stair_x
    private val stair_x: Int = x-width+1
    private val stair_y: Int = y-height+1

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
}
