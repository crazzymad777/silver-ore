module core.world.generator.ClusterOreGeneratorId;

import core.world.map.ClusterId;

struct ClusterOreGeneratorId {
  ClusterId id;
  ulong seed;
  int ver = 1; // version
}
