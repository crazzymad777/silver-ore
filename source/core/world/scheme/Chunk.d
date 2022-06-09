module core.world.scheme.Chunk;

class Chunk {
  import core.world.utils.ClusterCubeCoordinates;
  import core.world.utils.ChunkCubeCoordinates;
  import std.typecons: Nullable;
  import core.world.Cube;

  private uint offsetX, offsetY, offsetZ;
  this(ushort chunkId) {
    offsetX = (chunkId%16u)*16u;
    offsetY = ((chunkId/16u)%16u)*16u;
    offsetZ = (chunkId/(16u*16u))*16u;
  }

  private Cube[ChunkCubeCoordinates] cache;
  Nullable!Cube getCube(ChunkCubeCoordinates coors) {
    // chunk -> cube
    auto cube_ptr = (coors in cache);
    if (cube_ptr is null) {
      return Nullable!Cube(null);
      /* cache[coors] = new Cube();
      return Nullable!Cube(cache[coors]); */
    }
    return Nullable!Cube(*cube_ptr);
  }

  void setCube(ChunkCubeCoordinates coors, ref Cube cube) {
    cache[coors] = cube;
  }

  ulong cubesLoaded() {
    return cache.length;
  }

  /* Chunk transformer */
  auto transform(const ref ClusterCubeCoordinates coors) {
    import std.conv: to;
    return ChunkCubeCoordinates(to!ubyte(coors.x-offsetX), to!ubyte(coors.y-offsetY), to!ubyte(coors.z-offsetZ));
  }

  /* fun makeClusterCubeCoordinates(coors: ChunkCubeCoordinates): ClusterCubeCoordinates {
    return ClusterCubeCoordinates(coors.x+offsetX, coors.y+offsetY, coors.z+offsetZ)
  }

  fun getClusterCubeCoordinatesById(i: UInt): ClusterCubeCoordinates {
    return ClusterCubeCoordinates(i%16u + offsetX, (i/16u)%16u + offsetY, i/(16u*16u) + offsetZ)
  } */

  /* @Test fun testMakeClusterCubeCoordinates() {
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
  } */
}
