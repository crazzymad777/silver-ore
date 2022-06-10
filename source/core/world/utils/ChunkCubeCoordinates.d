module core.world.utils.ChunkCubeCoordinates;

struct ChunkCubeCoordinates {
    ubyte x, y, z;
    invariant {
      assert(x < 16);
      assert(y < 16);
      assert(z < 16);
    }

    /* fun getCubeId(): UInt {
        return x+y*16u+z*16u*16u
    } */
}
