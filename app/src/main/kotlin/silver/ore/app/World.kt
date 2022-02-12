package silver.ore.app

class World {
    val cache = HashMap<Any, Any>()
    val seed: Int = 0
    private val chunks = Array(16*16*16) { i -> generateChunk(i) }
    private fun generateChunk(i: Int): Chunk {
        return Chunk(i)
    }
    private fun getChunk(x: Int, y: Int, z: Int): Chunk {
        return chunks[x+y*16+z*16*16]
    }
    fun getCube(x: Int, y: Int, z: Int): Cube {
        val chunk = getChunk(x/16, y/16, z/16)
        return chunk.getCube(x, y, z)
    }
}
