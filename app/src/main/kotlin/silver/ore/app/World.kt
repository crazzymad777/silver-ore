package silver.ore.app

import silver.ore.app.utils.GlobalCubeCoordinates
import silver.ore.app.utils.WorldChunkCoordinates
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

    private fun getChunk(coors: WorldChunkCoordinates): Chunk {
        return generateChunk(coors.getClusterChunkCoordinates().getChunkId(), generator)
    }

    fun getChunkByCoordinates(coors: GlobalCubeCoordinates): Chunk {
        return getChunk(coors.getChunkCoordinates())
    }

    fun getCube(coors: GlobalCubeCoordinates): Cube {
        if (coors.x < 0 || coors.x >= 256 || coors.z < 0 || coors.z >= 256 || coors.y < 0 || coors.y >= 256) {
            return Cube(Material.VOID, Material.VOID)
        }
        val chunk = getChunk(coors.getChunkCoordinates())
//        return chunk.getCube(coors)
        return chunk.getLocalCube(chunk.chunkTransformer.getLocalCubeCoordinates(coors))
    }
}
