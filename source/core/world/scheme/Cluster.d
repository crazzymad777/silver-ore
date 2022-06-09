module core.wolrd.scheme.Cluster;

/// Cluster contains 16x16x16 chunks
class Cluster {
  import core.world.map.ClusterId;
  import core.world.IGenerator;

  private ClusterId id;
  private IGenerator generator;
  this(ClusterId id, IGenerator generator) {
    this.id = id;
    this.generator = generator;
  }
}
