package silver.ore.app

class Chunk(i: Int, private val generator: Generator) {
    private val chunkId = i
    private val offsetX = (chunkId%16)*16
    private val offsetY = ((chunkId/16)%16)*16
    private val offsetZ = (chunkId/(16*16))*16

    private val cubes = Array(16*16*16) {
        i -> generateCube(i)
    }
    private fun generateCube(i: Int): Cube {
        return generator.getCube(i%16 + offsetX, i/16 + offsetY, i/(16*16) + offsetZ)
    }
    private fun getLocalCube(x: Int, y: Int, z: Int): Cube {
        return cubes[x+y*16+z*16*16]
    }
    fun getCube(x: Int, y: Int, z: Int): Cube {
        return getLocalCube(x-offsetX, y-offsetY, z-offsetZ)
    }
}
