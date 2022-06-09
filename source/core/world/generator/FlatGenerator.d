module core.world.generator.FlatGenerator;

import core.world.utils.GlobalCubeCoordinates;
import core.game.material.Dispenser;
import core.game.material.Material;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

class FlatGenerator(T) : IGenerator!T {
  Nullable!Cube getCube(T coors) {
    auto d = Dispenser.get();

    Material floor;
    Material wall = d.getMaterial("Air");
    if (coors.z == 128L) {
      floor = d.getMaterial("Grass");
    } else if (coors.z <= 124L) {
      /* @Suppress("NAME_SHADOWING") val cube = generator.oreGenerator.getCube(coors)
      if (cube != null) {
      return cube
      } */
      wall = d.getMaterial("Stone");
      floor = d.getMaterial("Stone");
    } else if (coors.z > 128L) {
      wall = d.getMaterial("Air");
      floor = d.getMaterial("Air");
    } else {
      wall = d.getMaterial("Soil");
      floor = d.getMaterial("Soil");
    }
    return Nullable!Cube(new Cube(wall, floor));
  }
}
