module core.world.generator.ClusterOreGenerator;

import core.world.generator.ClusterOreGeneratorId;
import core.world.utils.ClusterCubeCoordinates;
import core.game.material.Dispenser;
import core.game.material.Material;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;
import core.game.Ore;

class ClusterOreGenerator : IGenerator!ClusterCubeCoordinates {
  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
      import std.math.exponential: pow;
      if (coors.z <= 124u) {
          auto newX = coors.x;
          auto newY = coors.y;
          auto newZ = coors.z;

          auto d = Dispenser.get();
          auto stone = d.getMaterial("Stone");
          auto cube = new Cube(stone, stone);
          foreach (cluster; clusters) {
              if (((cluster.x-newX).pow(2)+(cluster.y-newY).pow(2)+(cluster.z-newZ).pow(2)) < (cluster.radius.pow(2))) {
                  auto material = cluster.material;
                  auto ore = new Ore(material);
                  cube.setOre(ore);
                  return Nullable!Cube(cube);
              }
          }
      }
      return Nullable!Cube(null);
      /* return null */
  }

  struct OreCluster {
    int x;
    int y;
    int z;
    Material material;
    int radius;
  }

  OreCluster[] clusters;
  private ClusterOreGeneratorId id;
  this(ClusterOreGeneratorId id) {
    import core.world.utils.Seed: Random, make;
    import std.random: uniform;
    import std.format;
    this.id = id;
    auto str = format("%d:ores:%d:%d", id.seed, id.id.getSignedX(), id.id.getSignedY());
    auto rnd = Random(make(str));

    auto d = Dispenser.get();
    auto material = d.getMaterial("Gold");

    for (int i = 0; i < 8; i++)
        clusters ~= OreCluster(uniform(0, 256, rnd),
                               uniform(0, 256, rnd),
                               uniform(0, 128, rnd),
                               material,
                               uniform(5, 10, rnd));

    material = d.getMaterial("Silver");
    for (int i = 0; i < 24; i++)
        clusters ~= OreCluster(uniform(0, 256, rnd),
                               uniform(0, 256, rnd),
                               uniform(0, 128, rnd),
                               material,
                               uniform(5, 10, rnd));

    material = d.getMaterial("Tin");
    for (int i = 0; i < 16; i++)
        clusters ~= OreCluster(uniform(0, 256, rnd),
                               uniform(0, 256, rnd),
                               uniform(0, 128, rnd),
                               material,
                               uniform(5, 10, rnd));

    material = d.getMaterial("Copper");
    for (int i = 0; i < 16; i++)
        clusters ~= OreCluster(uniform(0, 256, rnd),
                               uniform(0, 256, rnd),
                               uniform(0, 128, rnd),
                               material,
                               uniform(5, 10, rnd));

    material = d.getMaterial("Iron");
    for (int i = 0; i < 32; i++)
        clusters ~= OreCluster(uniform(0, 256, rnd),
                               uniform(0, 256, rnd),
                               uniform(0, 128, rnd),
                               material,
                               uniform(5, 10, rnd));
  }
}
