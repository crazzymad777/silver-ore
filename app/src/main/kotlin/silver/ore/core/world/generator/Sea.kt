package silver.ore.core.world.generator

import silver.ore.core.game.Material
import silver.ore.core.world.utils.GlobalCubeCoordinates
import silver.ore.core.world.ClusterGenerator
import silver.ore.core.world.Cube
import silver.ore.core.world.Generator
import silver.ore.core.world.Tile
import kotlin.math.abs
import kotlin.math.max
import kotlin.math.sign

class Sea(val generator: Generator, private val tiles: List<Tile.TYPE>) : ClusterGenerator() {
    private fun getLevel(): Int {
        return 128
    }

    // TODO: change type to ClusterCubeCoordinates!!
    private fun getDepth(coors: GlobalCubeCoordinates): Int {
        if (coors.x < 0) {
            throw IllegalArgumentException("invalid coors.x: ${coors.x}")
        }

        if (coors.y < 0) {
            throw IllegalArgumentException("invalid coors.y: ${coors.y}")
        }

        val x = coors.x%256 // signed division!!
        val y = coors.y%256 // signed division!!
//        val x = (256+coors.x)%256
//        val y = (256+coors.y)%256
        val offsetX = x-128
        val offsetY = y-128

        // seems working
        val relation = if (offsetY == 0L) {
            2
        } else {
            offsetX / offsetY
        }

        var dirX = 0
        var dirY = 0
        if (abs(relation) >= 1) {
            dirX = sign(offsetX.toDouble()).toInt()
        } else {
            dirY = sign(offsetY.toDouble()).toInt()
        }

        val dir: Int = if (dirX == 0 && dirY == -1) {
            0
        } else if (dirX == 1) {
            2
        } else if (dirX == 0 && dirY == 1) {
            4
        } else {
            6
        }

        val dis: Long
        if (tiles[dir].isSea()) {
            dis = 0
        } else {
            val disX = abs(offsetX)
            val disY = abs(offsetY)
            dis = max(-disX-disY, -64L)
        }

        return (64L+dis).toInt()
    }

    // TODO: change type to ClusterCubeCoordinates!!
    override fun getCube(coors: GlobalCubeCoordinates): Cube {
        var floor: Material
        var wall: Material = Material.AIR
        val level = getLevel()

        val ucoors = GlobalCubeCoordinates(((coors.x.toULong())%256u).toLong(),
                                           ((coors.y.toULong())%256u).toLong(), coors.z)
        val depth = getDepth(ucoors)
        val bottom = level-depth

        if (ucoors.z in bottom..level) {
            floor = Material.WATER
        } else if (ucoors.z <= bottom-4) {
            @Suppress("NAME_SHADOWING") val cube = generator.oreGenerator.getCube(coors)
            if (cube != null) {
                return cube
            }
            wall = Material.STONE
            floor = Material.STONE
        } else if (coors.z > level) {
            wall = Material.AIR
            floor = Material.AIR
        } else {
            wall = Material.SILT
            floor = Material.SILT
            if (ucoors.x%256 < 5 || ucoors.x%256 > 250 || ucoors.y%256 < 5 || ucoors.y%256 > 250) {
                if (depth < 5) {
                    wall = Material.SAND
                    floor = Material.SAND
                }
            }
        }
        return Cube(wall, floor)
    }
}
