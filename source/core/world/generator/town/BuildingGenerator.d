module core.world.generator.town.BuildingGenerator;

import core.world.utils.ClusterCubeCoordinates;
import std.typecons: Nullable;
import core.world.IGenerator;
import core.world.Cube;

class BuildingGenerator : IGenerator!ClusterCubeCoordinates {
  import core.world.generator.town.Building;
  private Building[] generatedBuildings;
  private Building[] buildings;

  import std.random;
  this(ref Mt19937_64 rnd) {
    int number = uniform(32, 96, rnd);

    for(int i = 0; i < number; i++) {
      generatedBuildings ~= new Building(rnd);
    }

    foreach (building; generatedBuildings) {
        bool addBuilding = true;

        if (building.ignored) {
            addBuilding = false;
        } else {
            foreach (otherBuilding; generatedBuildings) {
                if (!otherBuilding.ignored) {
                    if (building != otherBuilding) {
                        import std.math, std.algorithm;

                        auto disX = abs(building.x-otherBuilding.x);
                        auto limitX = max(building.width + 1, otherBuilding.x + 1);
                        if (disX < limitX) {
                            auto disY = abs(building.y-otherBuilding.y);
                            auto limitY = max(building.height + 1, otherBuilding.height + 1);
                            if (disY < limitY) {
                                addBuilding = false;
                                building.ignored = true;
                                break;
                            }
                        }
                    }
                }
            }
        }

        if (addBuilding) {
            buildings ~= building;
        }
    }
  }

  Nullable!Cube getCube(ClusterCubeCoordinates coors) {
    import core.game.material.Dispenser;
    /* auto cube = new Cube(Dispenser.get().getMaterial("Air"), Dispenser.get().getMaterial("Wood"));
    return Nullable!Cube(cube); */

    Building building;
    foreach (build; buildings) {
        if (build.check(coors)) {
            building = build;
            break;
        }
    }

    if (building !is null) {
      /* auto cube = new Cube(Dispenser.get().getMaterial("Air"), Dispenser.get().getMaterial("Wood"));
      return Nullable!Cube(cube); */
        auto furniture = building.getFurniture(coors);
        auto wall = building.getWall(coors);
        auto cube = new Cube(wall, Dispenser.get().getMaterial("Wood"));
        return Nullable!Cube(cube);
    }

    return Nullable!Cube(null);
  }
}
