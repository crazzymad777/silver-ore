package silver.ore.app

import kotlin.random.Random

class World(config: WorldConfig = WorldConfig(generatorName = "flat")) {
    val cache = HashMap<Any, Any>()
    private val random = Random(config.seed)
    private val generator = config.getGenerator(random)
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