package silver.ore.app

import silver.ore.app.utils.ClusterChunkCoordinates
import silver.ore.app.utils.ClusterTransformer

class Cluster(val id: ClusterId, val generator: ClusterGenerator) {
    private val chunks = HashMap<Int, Chunk>()
    val clusterTransformer = ClusterTransformer(id)

    fun chunksLoaded(): Int {
        return chunks.count()
    }

    fun cubesLoaded(): Int {
        return chunks.map { it.value.cubesLoaded() }.toTypedArray().sum()
    }

    private fun generateChunk(i: Int, generator: ClusterGenerator): Chunk {
        var chunk = chunks[i]
        if (chunk != null) {
            return chunk
        }
        chunk = Chunk(i, generator)
        chunks[i] = chunk
        return chunk
    }

    fun getLocalChunk(coors: ClusterChunkCoordinates): Chunk {
        return generateChunk(coors.getChunkId(), generator)
    }
}
