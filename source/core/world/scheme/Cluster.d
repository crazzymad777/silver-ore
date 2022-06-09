module core.world.scheme.Cluster;

/// Cluster contains 16x16x16 chunks
class Cluster {
  import core.world.utils.GlobalCubeCoordinates;
  import core.world.utils.ClusterCubeCoordinates;
  import core.world.map.ClusterId;
  import core.world.scheme.Chunk;
  import core.world.IGenerator;
  import core.world.Cube;

  private ClusterId id;
  private IGenerator generator;
  private Chunk[uint] chunks;
  this(ClusterId id, IGenerator generator) {
    this.id = id;
    this.generator = generator;

    /* Cluster transformer */
    this.offsetX = ulong(id.getUnsignedX())*256u;
    this.offsetY = ulong(id.getUnsignedY())*256u;
  }

  private Cube[ClusterCubeCoordinates] cache;
  Cube getCube(ClusterCubeCoordinates coors) {
    // cluster -> chunk -> cube
    auto cube = (coors in cache);
    if (cube is null) {
      cache[coors] = new Cube();
      return cache[coors];
    }
    return *cube;
  }

  /* Cluster transformer */
  private ulong offsetX, offsetY;
  auto transform(GlobalCubeCoordinates coors) {
    import std.conv: to;
    auto x = ulong(coors.x)-offsetX;
    auto y = ulong(coors.y)-offsetY;
    return ClusterCubeCoordinates(to!uint(x), to!uint(y), to!uint(coors.z));
  }

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

  ulong cubesLoaded() {
    return cache.length;
  }
}
