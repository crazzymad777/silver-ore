package silver.ore.app.generator

import silver.ore.app.AbstractGenerator
import silver.ore.app.Cube
import silver.ore.app.Material
import silver.ore.app.game.Ore
import kotlin.Int.Companion.MAX_VALUE
import kotlin.math.pow
import kotlin.random.Random

class OreGenerator(random: Random = Random(0)) : AbstractGenerator(random) {
    private val offsetX = random.nextInt(until = MAX_VALUE) + 1
    private val offsetY = random.nextInt(until = MAX_VALUE) + 1
    private val offsetZ = random.nextInt(until = MAX_VALUE) + 1
    override fun getCube(x: Int, y: Int, z: Int): Cube? {
        if (z <= 124) {
            var ore: Ore? = null
            val newX = (x+offsetX)%256
            val newY = (y+offsetY)%256
            val newZ = (z+offsetZ)%256
            if ((newX - x).toDouble().pow(2) +(newY-y).toDouble().pow(2)+(newZ-z).toDouble().pow(2) < 125) {
                ore = Ore(Material.SILVER)
            }
            return Cube(Material.STONE, Material.STONE, ore = ore)
        }
        return null
    }
}
