package silver.ore.terminal

import silver.ore.core.World
import silver.ore.core.WorldConfig
import silver.ore.core.utils.GlobalCubeCoordinates

fun main() {
    val terminal = JLineTerminal()
    val type = terminal.getType()

    if (type == "dumb-color" || type == "dumb") {
        terminal.terminal.writer().println("Your terminal is $type. Continue to work? (y/n)")
        terminal.terminal.flush();
        var integer: Int
        var char: Char
        do {
            integer = terminal.reader.read()
            char = integer.toChar().lowercaseChar()
        } while(integer >= 0 && char != 'y' && char != 'n')

        if (integer < 0 || char == 'n') {
            return
        }
    }

    val world = World(WorldConfig(generatorName = "i1", enableNegativeCoordinates = true))
    val coors = world.getDefaultCoordinates()
    var x = coors.x
    var y = coors.y
    var z = coors.z

    var speed = 256
    do {
        terminal.terminal.writer().println("X: $x, Y: $y, Z: $z")
//        println("Chunk: ${world.getChunkByCoordinates(GlobalCubeCoordinates(x, y, z))} / Cluster loaded: ${world.clustersLoaded()} / Chunks loaded: ${world.chunksLoaded()} / Cubes loaded: ${world.cubesLoaded()}")
//        println("Max colors: ${Colors.DEFAULT_COLORS_256.size}")

        val newCoors = GlobalCubeCoordinates(x, y, z)
        val cluster = world.getCluster(newCoors.getChunkCoordinates())
        val clusterId = cluster.id

        val chunk = cluster.getLocalChunk(newCoors.getChunkCoordinates().getClusterChunkCoordinates())
        val chunkId = chunk.chunkId

        val cubeId = chunk.chunkTransformer.getLocalCubeCoordinates(cluster.clusterTransformer.getClusterCubeCoordinates(newCoors)).getCubeId()

        terminal.terminal.writer().println("Ore generators loaded: ${world.oreGeneratorsLoaded()}")
        terminal.terminal.writer().println("ClusterId: $clusterId / ChunkId: $chunkId / Cube: $cubeId")

        val cube = world.getCube(GlobalCubeCoordinates(x, y, z))
//        println(cube.fullDisplay())
        val item = cube.getItem()
        if (item != null) {
            terminal.terminal.writer().println("Item: ${item.getName()}")
        } else {
            terminal.terminal.writer().println("No items")
        }
        val builder = terminal.builder()
        for (i in -16..16) {
            for (j in -48..48) {
                if (i != 0 || j != 0) {
                    val glyph = Glyph(world.getCube(GlobalCubeCoordinates(x + j, y + i, z)))
                    builder.setForeground(glyph.foreground).append(glyph.char)
                } else {
                    builder.setForeground(RgbColor(255, 0, 0)).append('x')
                }
            }
            terminal.terminal.writer().println(builder.toAnsi())
            builder.clear()
        }
        terminal.terminal.flush();
        val integer = terminal.reader.read()
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
        terminal.clear()
    } while (char != 'q' && integer != -1)
}
