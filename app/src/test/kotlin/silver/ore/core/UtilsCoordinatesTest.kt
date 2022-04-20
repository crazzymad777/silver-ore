package silver.ore.core

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import silver.ore.core.world.ClusterId.Companion.signedClusterId
import silver.ore.core.world.utils.GlobalCubeCoordinates.Companion.fromInternalCoordinates
import silver.ore.core.world.ClusterId
import silver.ore.core.world.utils.*
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

    @Nested
    inner class ClusterTransformerTest {
        @Test fun testGetClusterCubeCoordinates() {
            for (i in 0..50) {
                val clusterId = signedClusterId(Random.nextLong()/256, Random.nextLong()/256)
                val clusterTransformer = ClusterTransformer(clusterId)

                val offsetX = clusterId.getUnsignedX().toULong()*256u
                val offsetY = clusterId.getUnsignedY().toULong()*256u

                val x = Random.nextUInt(0u, 256u) + offsetX
                val y = Random.nextUInt(0u, 256u) + offsetY
                val z = Random.nextUInt(0u, 256u)

                val global = GlobalCubeCoordinates(x.toLong(), y.toLong(), z.toLong())
                val cx = (global.x).toULong()-offsetX
                val cy = (global.y).toULong()-offsetY
                val actual = ClusterCubeCoordinates(cx.toUInt(), cy.toUInt(), global.z.toUInt())
                val expected = clusterTransformer.getClusterCubeCoordinates(global)

                assertEquals(expected, actual)
            }
        }

        @Test fun testGetGlobalCubeCoordinates() {
            for (i in 0..50) {
                val clusterId = signedClusterId(Random.nextLong()/256, Random.nextLong()/256)
                val clusterTransformer = ClusterTransformer(clusterId)

                val offsetX = clusterId.getUnsignedX().toULong()*256u
                val offsetY = clusterId.getUnsignedY().toULong()*256u

                val x = Random.nextUInt(0u, 256u) + offsetX
                val y = Random.nextUInt(0u, 256u) + offsetY
                val z = Random.nextUInt(0u, 256u)

                val actual = GlobalCubeCoordinates(x.toLong(), y.toLong(), z.toLong())
                val local = clusterTransformer.getClusterCubeCoordinates(actual)
                val expected = clusterTransformer.getGlobalCubeCoordinates(local)

                assertEquals(expected, actual)
            }
        }
    }

    @Test fun testGlobalCubeCoordinates() {
        for (i in 0..100) {
            val x = Random.nextLong()
            val y = Random.nextLong()
            val z = Random.nextLong()
            val expected = WorldChunkCoordinates(x.toULong()/16u, y.toULong()/16u, z.toULong()/16u)
            val actual = GlobalCubeCoordinates(x, y, z).getChunkCoordinates()
            assertEquals(expected, actual)
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

    @Test fun testFromInternalCoordinates() {
        val x = Random.nextInt().toLong()
        val y = Random.nextInt().toLong()
        val z = Random.nextInt().toLong()

        val actual = fromInternalCoordinates((-1*x).toULong(), (-1*y).toULong(), (-1*z).toULong())
        assertEquals(GlobalCubeCoordinates(-1*x, -1*y, -1*z), actual)
    }

    @Test fun TestGetClusterId() {
        val x = Random.nextInt().toLong()
        val y = Random.nextInt().toLong()
        val z = Random.nextInt().toLong()

        val global = GlobalCubeCoordinates(x, y, z)

        val ux = x.toULong()/16u
        val uy = y.toULong()/16u

        val coors = global.getChunkCoordinates()

        val actual = ClusterId(ux.toLong()/16, uy.toLong()/16)
        val expected = coors.getClusterId()
        assertEquals(expected, actual)
    }
}
