module core.world.WorldGenerator;

class WorldGenerator {
  import core.world.utils.ClusterCubeCoordinates;
  import core.world.map.ClusterId;
  import core.world.IGenerator;
  import core.world.Map;
  private ulong seed;
  private Map map;
  private string generatorName;

  this(long seed, Map map, string generatorName = "flat") {
    this.generatorName = generatorName;
    this.seed = seed;
    this.map = map;
  }

  package IGenerator!ClusterCubeCoordinates[ClusterId] clusterGenerators;
  IGenerator!ClusterCubeCoordinates getClusterGenerator(ClusterId clusterId) {
    auto generator_ptr = (clusterId in clusterGenerators);
    if (generator_ptr is null) {
      clusterGenerators[clusterId] = createClusterGenerator(clusterId);
      return clusterGenerators[clusterId];
    }
    return *generator_ptr;
  }

  IGenerator!ClusterCubeCoordinates createClusterGenerator(ClusterId clusterId) {
    import core.world.generator.FlatGenerator;
    import core.world.generator.SeaGenerator;
    import core.world.generator.i1;
    import core.world.map.Tile;

    auto type = map.getTileType(clusterId);
    if (type == Tile.TYPE.DESERT) {
      return new FlatGenerator(clusterId, seed, FlatGenerator.TYPE.SAND);
    } else if (type == Tile.TYPE.TOWN) {
      return new i1(clusterId, seed);
    } else if (type == Tile.TYPE.SEA) {
      return new SeaGenerator(clusterId, seed, map);
    }
    return new FlatGenerator(clusterId, seed, FlatGenerator.TYPE.GRASS);
  }
}
