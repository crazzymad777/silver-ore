module core.world.World;

import core.world.utils.GlobalCubeCoordinates;
import core.world.WorldConfig;
import core.world.IWorld;
import core.world.Cube;

class World : IWorld {
  import core.world.map.ClusterId;
  import core.world.map.BiomeId;
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

  bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
    return getCube(b).wall.isSolid();
  }

  // world contains clusters
  private Cluster[ClusterId] clusters;
  Cluster getCluster(ClusterId clusterId) {
    auto cluster_ptr = (clusterId in clusters);
    if (cluster_ptr is null) {
      auto generator = this.generator.getClusterGenerator(clusterId);
      clusters[clusterId] = new Cluster(clusterId, generator);
      return clusters[clusterId];
    }
    return *cluster_ptr;
  }

  export Cube getCube(GlobalCubeCoordinates coors) {
    import core.game.material.Dispenser;
    // world -> cluster -> chunk -> cube

    if (coors.z >= 256) {
      return new Cube(Dispenser.get().getMaterial("Void"), Dispenser.get().getMaterial("Void"));
    } else if (coors.z < 0) {
      return new Cube(Dispenser.get().getMaterial("Crust"), Dispenser.get().getMaterial("Crust"));
    }

    auto chunkCoors = coors.getChunkCoordinates();
    auto cluster = getCluster(chunkCoors.getClusterId());
    auto local = cluster.transform(coors);
    auto cube = cluster.getCube(local);
    if (cube is null) {
      cube = new Cube(Dispenser.get().getMaterial("Void"), Dispenser.get().getMaterial("Void"));
    }
    return cube;
  }

  import core.world.map.Tile;
  export Tile getTile(ClusterId clusterId) {
    // World -> Map -> Biome -> Tile ?
    return map.getTile(clusterId);
  }

  ulong clustersLoaded() {
    return clusters.length;
  }

  void clearBiomes() {
    map.clearBiomes();
  }

  void clearClusters() {
    clusters.clear();
    generator.clusterGenerators.clear();
  }

  ulong biomesLoaded() {
    return map.biomesLoaded();
  }

  BiomeId getBiomeId(ClusterId clusterId) {
    return map.getBiomeId(clusterId);
  }

  ulong chunksLoaded() {
    import std.algorithm;
    import std.range;
    return clusters.values.map!(x => x.chunksLoaded()).sum();
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
