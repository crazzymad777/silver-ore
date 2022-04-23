package silver.ore.terminal

import silver.ore.core.world.World
import silver.ore.core.world.WorldConfig
import silver.ore.core.world.utils.GlobalCubeCoordinates
import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Glyph
import silver.ore.terminal.base.Key
import silver.ore.terminal.base.RgbColor

class GameComponent(private val display: AbstractDisplay) : AbstractComponent() {
    private val world = World(WorldConfig(generatorName = "i1", enableNegativeCoordinates = true))
    private val coors = world.getDefaultCoordinates()
    private var updated = true
    private var exited = false
    var x = coors.x
    var y = coors.y
    var z = coors.z
    var speed = 256

    override fun read(): Key {
        return display.read()
    }

    override fun closed(): Boolean {
        return exited
    }

    override fun process() {

    }

    override fun recvKey(key: Key) {
        val integer = key.keycode
        when (integer.toChar()) {
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
            'q' -> {
                exited = true
            }
        }
        updated = true
    }

    override fun resize(width: Int, height: Int) {
        draw()
    }

    override fun update(): Boolean {
        return updated
    }

    override fun draw() {
        display.put(0, 0, Glyph.fromString("X: $x, Y: $y, Z: $z"))
        display.put(0, 1, Glyph.fromString("Chunk: ${world.getChunkByCoordinates(
            GlobalCubeCoordinates(x, y, z)
        )} / Cluster loaded: ${world.clustersLoaded()} / Chunks loaded: ${world.chunksLoaded()} / Cubes loaded: ${world.cubesLoaded()}"))

        val newCoors = GlobalCubeCoordinates(x, y, z)
        val cluster = world.getCluster(newCoors.getChunkCoordinates())
        val clusterId = cluster.id

        val chunk = cluster.getLocalChunk(newCoors.getChunkCoordinates().getClusterChunkCoordinates())
        val chunkId = chunk.chunkId

        val cubeId = chunk.chunkTransformer.getLocalCubeCoordinates(cluster.clusterTransformer.getClusterCubeCoordinates(newCoors)).getCubeId()

        display.put(0, 2, Glyph.fromString("ClusterId: $clusterId (${world.map.getTileType(clusterId)}) / ChunkId: $chunkId / Cube: $cubeId"))

        val cube = world.getCube(GlobalCubeCoordinates(x, y, z))
        val item = cube.getItem()
        if (item != null) {
            display.put(0, 3, Glyph.fromString("Item: ${item.getName()}"))
        } else {
            display.put(0, 3, Glyph.fromString("Wall: ${cube.wall} / Floor: ${cube.floor}"))
        }
        var row: Int
        for (i in -16..16) {
            row = i + 16
            val rowWidth = 65
            val array = Array(rowWidth) {
                val j = it - rowWidth/2
                if (i != 0 || j != 0) {
                    val glyph = silver.ore.terminal.app.Glyph(
                        world.getCube(GlobalCubeCoordinates(x + j, y + i, z)),
                        world.getCube(GlobalCubeCoordinates(x + j, y + i, z - 1))
                    ).getGlyph()
                    Glyph(glyph.foreground, glyph.background, glyph.char)
                } else {
                    Glyph(RgbColor(255, 0, 0), char = 'x')
                }
            }
            display.put(0, 4+row, array)
        }

        display.reset()
        display.update()
        updated = false
    }
}
