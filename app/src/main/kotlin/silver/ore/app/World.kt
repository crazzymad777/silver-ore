package silver.ore.app

import kotlin.random.Random

// TODO: clusters. One cluster 16x16x16 chunks.

class World(config: WorldConfig = WorldConfig(generatorName = "flat")) {
    private val random = Random(config.seed)
    private val generator = config.getGenerator(random)
    private val chunks = HashMap<Int, Chunk>()

    fun chunksLoaded(): Int {
        return chunks.count()
    }

    fun cubesLoaded(): Int {
        return chunks.map { it.value.cubesLoaded() }.toTypedArray().sum()
    }

    private fun generateChunk(i: Int, generator: WorldGenerator): Chunk {
        var chunk = chunks[i]
        if (chunk != null) {
            return chunk
        }
        chunk = Chunk(i, generator)
        chunks[i] = chunk
        return chunk
    }

    private fun getChunk(x: Int, y: Int, z: Int): Chunk {
        return generateChunk(x+y*16+z*16*16, generator)
    }

    fun getChunkByCoordinates(x: Int, y: Int, z: Int): Chunk {
        return getChunk(x/16, y/16, z/16)
    }

    fun getCube(x: Int, y: Int, z: Int): Cube {
        if (x < 0 || x >= 256 || z < 0 || z >= 256 || y < 0 || y >= 256) {
            return Cube(Material.VOID, Material.VOID)
        }
        val chunk = getChunk(x/16, y/16, z/16)
        return chunk.getCube(x, y, z)
    }
}
