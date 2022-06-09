module core.world.utils.ChunkCubeCoordinates;

struct ChunkCubeCoordinates {
    ubyte x, y, z;
    invariant {
      assert(x < 16);
      assert(y < 16);
      assert(z < 16);
    }
}
