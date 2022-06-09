module core.world.scheme.Cluster;

/// Cluster contains 16x16x16 chunks
class Cluster {
  import core.world.utils.GlobalCubeCoordinates;
  import core.world.utils.ClusterCubeCoordinates;
  import core.world.map.ClusterId;
  import core.world.scheme.Chunk;
  import std.typecons: Nullable;
  import core.world.IGenerator;
  import core.world.Cube;

  private ClusterId id;
  private IGenerator!ClusterCubeCoordinates generator;
  private Chunk[ushort] chunks;
  this(ClusterId id, IGenerator!ClusterCubeCoordinates generator) {
    this.id = id;
    this.generator = generator;

    /* Cluster transformer */
    this.offsetX = ulong(id.getUnsignedX())*256u;
    this.offsetY = ulong(id.getUnsignedY())*256u;
  }

  Chunk getChunk(ushort id) {
    auto chunk_ptr = (id in chunks);
    if (chunk_ptr is null) {
      auto chunk = new Chunk(id);
      chunks[id] = chunk;
      return chunk;
    }
    return *chunk_ptr;
  }

  Cube getCube(ClusterCubeCoordinates coors) {
    // cluster -> chunk -> cube
    auto chunkId = coors.getClusterChunkCoordinates().getChunkId();
    auto chunk = getChunk(chunkId);
    auto local = chunk.transform(coors);
    auto nullableCube = chunk.getCube(local);
    if (nullableCube.get is null) {
      auto cube = generator.getCube(coors);
      assert(cube.get !is null);
      chunk.setCube(local, cube.get);
      return cube.get;
    }

    assert(nullableCube.get !is null);
    return nullableCube.get;
  }

  /* Cluster transformer */
  private ulong offsetX, offsetY;
  auto transform(const ref GlobalCubeCoordinates coors) {
    import std.conv: to;
    auto x = ulong(coors.x)-offsetX;
    auto y = ulong(coors.y)-offsetY;
    return ClusterCubeCoordinates(to!uint(x), to!uint(y), to!uint(coors.z));
  }

  /* fun getGlobalCubeCoordinates(clusterCoors: ClusterCubeCoordinates): GlobalCubeCoordinates {
    return GlobalCubeCoordinates.fromInternalCoordinates(
      clusterCoors.x + offsetX,
      clusterCoors.y + offsetY,
      clusterCoors.z.toULong()
    )
  } */

  // TODO: migrate transform test
  /* @Test fun testGetClusterCubeCoordinates() {
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
  } */

  /* @Test fun testGetGlobalCubeCoordinates() {
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
  } */

  ulong cubesLoaded() {
    import std.algorithm;
    import std.range;
    return chunks.values.map!(x => x.cubesLoaded()).sum();
  }
}
