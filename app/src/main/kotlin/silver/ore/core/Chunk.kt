package silver.ore.core

import silver.ore.core.utils.ChunkCubeCoordinates
import silver.ore.core.utils.ChunkTransformer

class Chunk(i: Int, private val generator: ClusterGenerator, private val cluster: Cluster) {
    val chunkTransformer = ChunkTransformer(i)
    val chunkId = i

    override fun toString(): String {
        return "$chunkId"
    }

    private val cubes = HashMap<Int, Cube>()

    fun cubesLoaded(): Int {
        return cubes.count()
    }

    private fun generateCube(i: Int): Cube {
        var cube = cubes[i]
        if (cube != null) {
            return cube
        }

        val coors = cluster.clusterTransformer.getGlobalCubeCoordinates(chunkTransformer.getClusterCubeCoordinatesById(i))
        cube = generator.getCube(coors)
        if (cube != null) {
            cubes[i] = cube
            return cube
        }

        return Cube(Material.VOID, Material.VOID)
    }

    fun getLocalCube(coors: ChunkCubeCoordinates): Cube {
        return generateCube(coors.getCubeId())
    }

//    fun getCube(coors: GlobalCubeCoordinates): Cube {
//        return getLocalCube(ChunkCubeCoordinates(coors.x-offsetX, coors.y-offsetY, coors.z-offsetZ))
//    }
}
