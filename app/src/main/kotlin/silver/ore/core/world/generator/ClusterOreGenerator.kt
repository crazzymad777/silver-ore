package silver.ore.core.world.generator

import silver.ore.core.world.Cube
import silver.ore.core.game.Material
import silver.ore.core.game.Ore
import silver.ore.core.world.utils.ClusterCubeCoordinates
import silver.ore.core.world.utils.Seed
import java.util.*
import kotlin.math.pow
import kotlin.random.Random

class ClusterOreGenerator(private val id: ClusterOreGeneratorId) {
    data class Cluster(val x: Int, val y: Int, val z: Int, val material: Material, val radius: Int)

    val random: Random = Random(Seed.make("${id.seed}:ores:${id.clusterId.getSignedX()}:${id.clusterId.getSignedY()}"))

    // gold (1-5), silver (1-15), tin (1-10), copper (1-15), iron (1-20)
    private val oreClusters: Vector<Cluster> = Vector()
    private fun produce(): Int {
        return random.nextInt(0, 256)
    }
    init {
        for (i in 1..8)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.GOLD, random.nextInt(5, 10)))
        for (i in 1..24)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.SILVER, random.nextInt(5, 10)))
        for (i in 1..16)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.TIN, random.nextInt(5, 10)))
        for (i in 1..16)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.COPPER, random.nextInt(5, 10)))
        for (i in 1..32)
            oreClusters.addElement(Cluster(produce(), produce(), random.nextInt(0, 128), Material.IRON, random.nextInt(5, 10)))
    }

    fun getCube(coors: ClusterCubeCoordinates): Cube? {
        if (coors.z <= 124u) {
            var ore: Ore? = null
            val newX = coors.x
            val newY = coors.y
            val newZ = coors.z
            for (cluster in oreClusters) {
                if ((newX.toInt() - cluster.x).toDouble().pow(2) + (newY.toInt() -  cluster.y).toDouble().pow(2) + (newZ.toInt() -  cluster.z).toDouble().pow(2) < cluster.radius.toDouble().pow(2)) {
                    ore = Ore(cluster.material)
                    break
                }
            }
            return Cube(Material.STONE, Material.STONE, ore = ore)
        }
        return null
    }
}
