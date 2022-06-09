module core.world.World;

import core.world.utils.GlobalCubeCoordinates;
import core.world.WorldConfig;
import core.world.Cube;

class World {
  import core.world.map.ClusterId;
  import core.world.scheme.Cluster;
  import core.world.WorldGenerator;
  import core.world.Map;

  // N.B.: world generator have own associative array of cluster generators
  private WorldGenerator generator;
  private WorldConfig config;
  private Map map;
  this(WorldConfig config = new WorldConfig()) {
    this.config = config;
    map = new Map(config.seed);
    generator = new WorldGenerator(config.seed, map, config.generatorName);
  }

  // world contains clusters
  private Cluster[ClusterId] clusters;
  Cluster getCluster(ClusterId clusterId) {
    auto cluster_ptr = (clusterId in clusters);
    if (cluster_ptr is null) {
      auto generator = this.generator.getGenerator(clusterId);
      clusters[clusterId] = new Cluster(clusterId, generator);
      return clusters[clusterId];
    }
    return *cluster_ptr;
  }

  Cube getCube(GlobalCubeCoordinates coors) {
    // world -> cluster -> chunk -> cube
    auto chunkCoors = coors.getChunkCoordinates();
    auto cluster = getCluster(chunkCoors.getClusterId());
    auto local = cluster.transform(coors);
    return cluster.getCube(local);
  }

  // return chunk
  int getChunkByCoordinates(GlobalCubeCoordinates coors) {
    return 0;
  }

  ulong clustersLoaded() {
    return clusters.length;
  }

  int chunksLoaded() {
    return 0;
  }

  ulong cubesLoaded() {
    import std.algorithm;
    import std.range;
    return clusters.values.map!(x => x.cubesLoaded()).sum();
  }

  auto getDefaultCoordinates() {
    return GlobalCubeCoordinates(long(map.defaultClusterId.getSignedX()*256+128),
                                 long(map.defaultClusterId.getSignedY()*256+128),
                                 128);
  }
}
