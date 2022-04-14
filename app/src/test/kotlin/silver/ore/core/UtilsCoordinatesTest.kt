package silver.ore.core

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import silver.ore.core.utils.*
import kotlin.random.Random
import kotlin.random.nextUInt

class UtilsCoordinatesTest {
    @Nested
    inner class ChunkTransformerTest {
        @Test fun testMakeClusterCubeCoordinates() {
            for (i in 0..50) {
                val chunkId = Random.nextUInt(0u, 16u*16u*16u)
                val chunkTransformer = ChunkTransformer(chunkId)

                val offsetX = (chunkId%16u)*16u
                val offsetY = ((chunkId/16u)%16u)*16u
                val offsetZ = (chunkId/(16u*16u))*16u

                val x = Random.nextUInt(0u, 16u)
                val y = Random.nextUInt(0u, 16u)
                val z = Random.nextUInt(0u, 16u)

                val actual = chunkTransformer.makeClusterCubeCoordinates(ChunkCubeCoordinates(x, y, z))
                val expected = ClusterCubeCoordinates(x+offsetX, y+offsetY, z+offsetZ)
                assertEquals(expected, actual)
            }
        }

        @Test fun testGetClusterCubeCoordinatesById() {
            for (i in 0..50) {
                val chunkId = Random.nextUInt(0u, 16u*16u*16u)
                val chunkTransformer = ChunkTransformer(chunkId)

                val x = Random.nextUInt(0u, 16u)
                val y = Random.nextUInt(0u, 16u)
                val z = Random.nextUInt(0u, 16u)

                val local = ChunkCubeCoordinates(x, y, z)
                val actual = chunkTransformer.makeClusterCubeCoordinates(local)
                val cubeId = local.getCubeId()
                val expected = chunkTransformer.getClusterCubeCoordinatesById(cubeId)

                assertEquals(expected, actual)
            }
        }

        @Test fun testGetLocalCubeCoordinates() {
            for (i in 0..50) {
                val chunkId = Random.nextUInt(0u, 16u*16u*16u)
                val chunkTransformer = ChunkTransformer(chunkId)

                val offsetX = (chunkId%16u)*16u
                val offsetY = ((chunkId/16u)%16u)*16u
                val offsetZ = (chunkId/(16u*16u))*16u

                val x = Random.nextUInt(0u, 16u)
                val y = Random.nextUInt(0u, 16u)
                val z = Random.nextUInt(0u, 16u)

                val actual = ChunkCubeCoordinates(x, y, z)
                val global = GlobalCubeCoordinates((x+offsetX).toLong(), (y+offsetY).toLong(), (z+offsetZ).toLong())
                val local = ClusterTransformer(ClusterId(0, 0)).getClusterCubeCoordinates(global)
                val expected = chunkTransformer.getLocalCubeCoordinates(local)

                assertEquals(expected, actual)
            }
        }
    }

    @Test fun testGlobalCubeCoordinates() {
        for (i in 0..100) {
            val x = Random.nextLong()
            val y = Random.nextLong()
            val z = Random.nextLong()
            val actual = GlobalCubeCoordinates(x, y, z).getChunkCoordinates()
            assertEquals(WorldChunkCoordinates((x/16).toULong(), (y/16).toULong(), (z/16).toULong()), actual)
        }
    }

    @Test fun testClusterChunkCoordinates() {
        for (i in 0..100) {
            val x = Random.nextUInt(0u, 16u)
            val y = Random.nextUInt(0u, 16u)
            val z = Random.nextUInt(0u, 16u)
            val actual = ClusterChunkCoordinates(x, y, z).getChunkId()
            assertEquals(x+y*16u+z*16u*16u, actual)
        }
    }

    @Test fun testWorldChunkCoordinates() {
        for (i in 0..100) {
            val x = Random.nextUInt()
            val y = Random.nextUInt()
            val z = Random.nextUInt()
            val actual = WorldChunkCoordinates(x.toULong(), y.toULong(), z.toULong()).getClusterChunkCoordinates()
            assertEquals(ClusterChunkCoordinates(x%16u, y%16u, z%16u), actual)
        }
    }

    @Test fun testChunkCubeCoordinates() {
        for (i in 0..100) {
            val x = Random.nextUInt(0u, 16u)
            val y = Random.nextUInt(0u, 16u)
            val z = Random.nextUInt(0u, 16u)
            val actual = ChunkCubeCoordinates(x, y, z).getCubeId()
            assertEquals(x+y*16u+z*16u*16u, actual)
        }
    }
}
