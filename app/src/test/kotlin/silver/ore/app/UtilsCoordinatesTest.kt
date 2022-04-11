package silver.ore.app

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import silver.ore.app.utils.*
import kotlin.random.Random

class UtilsCoordinatesTest {
    @Nested
    inner class ChunkTransformerTest {
        @Test fun testMakeGlobalCubeCoordinates() {
            for (i in 0..50) {
                val chunkId = Random.nextInt(0, 16*16*16)
                val chunkTransformer = ChunkTransformer(chunkId)

                val offsetX = (chunkId%16)*16
                val offsetY = ((chunkId/16)%16)*16
                val offsetZ = (chunkId/(16*16))*16

                val x = Random.nextInt(0, 16)
                val y = Random.nextInt(0, 16)
                val z = Random.nextInt(0, 16)

                val actual = chunkTransformer.makeGlobalCubeCoordinates(ChunkCubeCoordinates(x, y, z))
                val expected = GlobalCubeCoordinates(x+offsetX, y+offsetY, z+offsetZ)
                assertEquals(expected, actual)
            }
        }

        @Test fun testGetGlobalCubeCoordinatesById() {
            for (i in 0..50) {
                val chunkId = Random.nextInt(0, 16*16*16)
                val chunkTransformer = ChunkTransformer(chunkId)

                val x = Random.nextInt(0, 16)
                val y = Random.nextInt(0, 16)
                val z = Random.nextInt(0, 16)

                val local = ChunkCubeCoordinates(x, y, z)
                val actual = chunkTransformer.makeGlobalCubeCoordinates(local)
                val cubeId = local.getCubeId()
                val expected = chunkTransformer.getGlobalCubeCoordinatesById(cubeId)

                assertEquals(expected, actual)
            }
        }

        @Test fun testGetLocalCubeCoordinates() {
            for (i in 0..50) {
                val chunkId = Random.nextInt(0, 16*16*16)
                val chunkTransformer = ChunkTransformer(chunkId)

                val offsetX = (chunkId%16)*16
                val offsetY = ((chunkId/16)%16)*16
                val offsetZ = (chunkId/(16*16))*16

                val x = Random.nextInt(0, 16)
                val y = Random.nextInt(0, 16)
                val z = Random.nextInt(0, 16)

                val actual = ChunkCubeCoordinates(x, y, z)
                val global = GlobalCubeCoordinates(x+offsetX, y+offsetY, z+offsetZ)
                val local = ClusterTransformer(ClusterId(0, 0)).getClusterCubeCoordinates(global)
                val expected = chunkTransformer.getLocalCubeCoordinates(local)

                assertEquals(expected, actual)
            }
        }
    }

    @Test fun testGlobalCubeCoordinates() {
        for (i in 0..100) {
            val x = Random.nextInt()
            val y = Random.nextInt()
            val z = Random.nextInt()
            val actual = GlobalCubeCoordinates(x, y, z).getChunkCoordinates()
            assertEquals(WorldChunkCoordinates(x/16, y/16, z/16), actual)
        }
    }

    @Test fun testClusterChunkCoordinates() {
        for (i in 0..100) {
            val x = Random.nextInt(0, 16)
            val y = Random.nextInt(0, 16)
            val z = Random.nextInt(0, 16)
            val actual = ClusterChunkCoordinates(x, y, z).getChunkId()
            assertEquals(x+y*16+z*16*16, actual)
        }
    }

    @Test fun testWorldChunkCoordinates() {
        for (i in 0..100) {
            // ClusterChunkCoordinates fails init without range (if x, y or z less than zero)
            val x = Random.nextInt(0, 10000)
            val y = Random.nextInt(0, 10000)
            val z = Random.nextInt(0, 10000)
            val actual = WorldChunkCoordinates(x, y, z).getClusterChunkCoordinates()
            assertEquals(ClusterChunkCoordinates(x%16, y%16, z%16), actual)
        }
    }

    @Test fun testChunkCubeCoordinates() {
        for (i in 0..100) {
            val x = Random.nextInt(0, 16)
            val y = Random.nextInt(0, 16)
            val z = Random.nextInt(0, 16)
            val actual = ChunkCubeCoordinates(x, y, z).getCubeId()
            assertEquals(x+y*16+z*16*16, actual)
        }
    }
}
