package silver.ore.app

import kotlin.random.Random

class World(private val generator: Generator = Generator.FLAT) {
    val cache = HashMap<Any, Any>()
    var unixTime = System.currentTimeMillis() / 1000L
    private val seed: Long = unixTime
    val random = Random(seed)
    private val chunks = Array(16*16*16) { i -> generateChunk(i, generator) }

    private fun generateChunk(i: Int, generator: Generator): Chunk {
        return Chunk(i, generator)
    }
    private fun getChunk(x: Int, y: Int, z: Int): Chunk {
        return chunks[x+y*16+z*16*16]
    }
    fun getCube(x: Int, y: Int, z: Int): Cube {
        val chunk = getChunk(x/16, y/16, z/16)
        return chunk.getCube(x, y, z)
    }
}
