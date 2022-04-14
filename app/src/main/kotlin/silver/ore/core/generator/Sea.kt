package silver.ore.core.generator

import silver.ore.core.*
import silver.ore.core.utils.GlobalCubeCoordinates
import kotlin.math.abs
import kotlin.math.max
import kotlin.math.sign

class Sea(val generator: Generator, private val tiles: List<Tile.TYPE>) : ClusterGenerator() {
    private fun getLevel(): Int {
        return 128
    }

    private fun getDepth(coors: GlobalCubeCoordinates): Int {
        val x = coors.x%256
        val y = coors.y%256
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

    override fun getCube(coors: GlobalCubeCoordinates): Cube {
        var floor: Material
        var wall: Material = Material.AIR
        val level = getLevel()
        val depth = getDepth(coors)
        val bottom = level-depth

        if (coors.z in bottom..level) {
            floor = Material.WATER
        } else if (coors.z <= bottom-4) {
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
            if (coors.x%256 < 5 || coors.x%256 > 250 || coors.y%256 < 5 || coors.y%256 > 250) {
                if (depth < 5) {
                    wall = Material.SAND
                    floor = Material.SAND
                }
            }
        }
        return Cube(wall, floor)
    }
}
