package silver.ore.app.generator

import kotlin.math.abs
import kotlin.random.Random

class Building(random: Random) {
    private val x: Int = random.nextInt()%256;
    private val y: Int = random.nextInt()%256;
    private val z: Int = random.nextInt()%256;
    private val width: Int = random.nextInt()%4+4
    private val height = random.nextInt()%4+4
    private val basement: Boolean = random.nextBoolean()
    private val loft: Boolean = random.nextBoolean()
    fun check(x: Int, y: Int, z: Int): Boolean {
        if (abs(this.x-x) < width && abs(this.y-y) < height) {
            if (z == this.z || (z+1 == this.z && this.loft) || (z+1 == this.z && this.basement)) {
                return true;
            }
        }
        return false;
    }
    fun isWall(x: Int, y: Int, z: Int): Boolean {
        if (abs(this.x-x) == width && this.y-y == height) {
            if (z == this.z || (z+1 == this.z && this.loft) || (z+1 == this.z && this.basement)) {
                return true;
            }
        }
        return false;
    }
}
