package silver.ore.terminal.app

import silver.ore.core.world.World
import silver.ore.core.world.WorldConfig
import silver.ore.core.world.utils.GlobalCubeCoordinates
import silver.ore.terminal.base.JLineDisplay
import silver.ore.terminal.base.RgbColor

import silver.ore.terminal.base.Glyph as BaseGlyph

fun main() {
    val display = JLineDisplay()
    val world = World(WorldConfig(generatorName = "i1", enableNegativeCoordinates = true))
    val coors = world.getDefaultCoordinates()
    var x = coors.x
    var y = coors.y
    var z = coors.z

    var speed = 256
    do {
        display.put(0, 0, silver.ore.terminal.base.Glyph.fromString("X: $x, Y: $y, Z: $z"))
        display.put(0, 1, silver.ore.terminal.base.Glyph.fromString("Chunk: ${world.getChunkByCoordinates(GlobalCubeCoordinates(x, y, z))} / Cluster loaded: ${world.clustersLoaded()} / Chunks loaded: ${world.chunksLoaded()} / Cubes loaded: ${world.cubesLoaded()}"))

        val newCoors = GlobalCubeCoordinates(x, y, z)
        val cluster = world.getCluster(newCoors.getChunkCoordinates())
        val clusterId = cluster.id

        val chunk = cluster.getLocalChunk(newCoors.getChunkCoordinates().getClusterChunkCoordinates())
        val chunkId = chunk.chunkId

        val cubeId = chunk.chunkTransformer.getLocalCubeCoordinates(cluster.clusterTransformer.getClusterCubeCoordinates(newCoors)).getCubeId()

//        terminal.terminal.writer().println("Ore generators loaded: ${world.oreGeneratorsLoaded()}")
        display.put(0, 2, BaseGlyph.fromString("ClusterId: $clusterId (${world.map.getTileType(clusterId)}) / ChunkId: $chunkId / Cube: $cubeId"))

        val cube = world.getCube(GlobalCubeCoordinates(x, y, z))
//        println(cube.fullDisplay())
        val item = cube.getItem()
        if (item != null) {
            display.put(0, 3, BaseGlyph.fromString("Item: ${item.getName()}"))
        } else {
            display.put(0, 3, BaseGlyph.fromString("Wall: ${cube.wall} / Floor: ${cube.floor}"))
        }
        var row = 0
        for (i in -16..16) {
            row = i + 16
            var column = 0
            for (j in -48..48) {
                column = j + 48
                if (i != 0 || j != 0) {
                    val glyph = Glyph(world.getCube(GlobalCubeCoordinates(x + j, y + i, z)),
                                      world.getCube(GlobalCubeCoordinates(x + j, y + i, z - 1))).getGlyph()
                    display.put(column, 4+row, BaseGlyph(glyph.foreground, glyph.background, glyph.char))
                } else {
                    display.put(column, 4+row, BaseGlyph(RgbColor(255, 0, 0), char = 'x'))
                }
            }
        }
        display.reset()
        display.update()
        val integer = display.read().keycode
        val char = integer.toChar()
        when (char) {
            'w' -> {
                y--
            }
            's' -> {
                y++
            }
            'a' -> {
                x--
            }
            'd' -> {
                x++
            }
            'e' -> {
                z--
            }
            'r' -> {
                z++
            }
            '6' -> {
                x += speed
            }
            '4' -> {
                x -= speed
            }
            '8' -> {
                y -= speed
            }
            '2' -> {
                y += speed
            }
            'm' -> {
                speed = if (speed == 256) {
                    16
                } else {
                    256
                }
            }
        }
    } while (char != 'q' && integer != -1)
}
