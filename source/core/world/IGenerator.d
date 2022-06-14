module core.world.IGenerator;

interface IGenerator(T) {
  import std.typecons: Nullable;
  import core.world.Cube;

  abstract Nullable!Cube getCube(T coors);
}
