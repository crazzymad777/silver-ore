module core.world.WorldGenerator;

class WorldGenerator {
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

  private IGenerator[ClusterId] generators;
  IGenerator getGenerator(ClusterId clusterId) {
    auto generator_ptr = (clusterId in generators);
    if (generator_ptr is null) {
      generators[clusterId] = createGenerator(clusterId);
      return generators[clusterId];
    }
    return *generator_ptr;
  }

  IGenerator createGenerator(ClusterId clusterId) {
    import core.world.generator.DummyGenerator;
    return new DummyGenerator();
  }
}
