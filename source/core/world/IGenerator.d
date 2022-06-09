module core.world.IGenerator;

interface IGenerator(T) {
  import core.world.utils.GlobalCubeCoordinates;
  import std.typecons: Nullable;
  import core.world.Cube;

  abstract Nullable!Cube getCube(T coors);
}
