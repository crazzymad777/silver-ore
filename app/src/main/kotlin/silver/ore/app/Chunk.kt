package silver.ore.app

class Chunk(i: Int, private val generator: WorldGenerator) {
    private val chunkId = i
    private val offsetX = (chunkId%16)*16
    private val offsetY = ((chunkId/16)%16)*16
    private val offsetZ = (chunkId/(16*16))*16

    override fun toString(): String {
        return "$chunkId:$offsetX:$offsetY:$offsetZ"
    }

    private val cubes = HashMap<Int, Cube>()

    private fun generateCube(i: Int): Cube {
        var cube = cubes[i]
        if (cube != null) {
            return cube
        }

        cube = generator.getCube(i%16 + offsetX, (i/16)%16 + offsetY, i/(16*16) + offsetZ)
        if (cube != null) {
            cubes[i] = cube
            return cube
        }

        return Cube(Material.VOID, Material.VOID)
    }

    private fun getLocalCube(x: Int, y: Int, z: Int): Cube {
        return generateCube(x+y*16+z*16*16)
    }

    fun getCube(x: Int, y: Int, z: Int): Cube {
        return getLocalCube(x-offsetX, y-offsetY, z-offsetZ)
    }
}
