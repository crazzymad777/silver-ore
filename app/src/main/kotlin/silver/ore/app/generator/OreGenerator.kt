package silver.ore.app.generator

import silver.ore.app.AbstractGenerator
import silver.ore.app.Cube
import silver.ore.app.Material
import silver.ore.app.game.Ore
import silver.ore.app.utils.GlobalCubeCoordinates
import java.util.*
import kotlin.Int.Companion.MAX_VALUE
import kotlin.math.pow
import kotlin.random.Random

data class Cluster(val x: Int, val y: Int, val z: Int, val material: Material, val radius: Int)

class OreGenerator(random: Random = Random(0)) : AbstractGenerator(random) {
    private val offsetX = random.nextInt(until = MAX_VALUE) + 1
    private val offsetY = random.nextInt(until = MAX_VALUE) + 1
    private val offsetZ = random.nextInt(until = MAX_VALUE) + 1
    // gold (1-5), silver (1-15), tin (1-10), copper (1-15), iron (1-20)
    private val oreClusters: Vector<Cluster> = Vector()
    private fun produce(): Int {
        return random.nextInt(0, 256)
    }
    init {
        for (i in 1..5)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.GOLD, random.nextInt(5, 10)))
        for (i in 1..15)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.SILVER, random.nextInt(5, 10)))
        for (i in 1..10)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.TIN, random.nextInt(5, 10)))
        for (i in 1..15)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.COPPER, random.nextInt(5, 10)))
        for (i in 1..20)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.IRON, random.nextInt(5, 10)))
    }
    override fun getCube(coors: GlobalCubeCoordinates): Cube? {
        if (coors.z <= 124) {
            var ore: Ore? = null
            val newX = (coors.x+offsetX)%256
            val newY = (coors.y+offsetY)%256
            val newZ = (coors.z+offsetZ)%256
            for (cluster in oreClusters) {
                if ((newX - cluster.x).toDouble().pow(2) + (newY -  cluster.y).toDouble().pow(2) + (newZ -  cluster.z).toDouble().pow(2) < cluster.radius.toDouble().pow(2)) {
                    ore = Ore(cluster.material)
                    break
                }
            }
            return Cube(Material.STONE, Material.STONE, ore = ore)
        }
        return null
    }
}
