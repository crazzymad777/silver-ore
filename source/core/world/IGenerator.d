module core.world.IGenerator;

interface IGenerator {
  import core.world.utils.GlobalCubeCoordinates;
  import std.typecons: Nullable;
  import core.world.Cube;

  abstract Nullable!Cube getCube(GlobalCubeCoordinates coors);
}
