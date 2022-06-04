module terminal.GameComponent;
import terminal.AbstractComponent;
import terminal.base.Key;
import terminal.app.Glyph;

import std.stdio;
import std.format;

import core.world.utils;
import core.world.World;

class GameComponent : AbstractComponent {
    private auto world = new World();
    private GlobalCubeCoordinates coors;
    private auto updated = true;
    private auto exited = true; // should be false
    private auto speed = 256;

    this() {
       this.coors = world.getDefaultCoordinates();
    }

    // obtain key
    override Key read() {
      return new Key();
    }

    override bool closed() {
      return exited;
    }

    override void process() {

    }

    override void recvKey(Key key) {
      // handle key
    }

    override void resize(int width, int height) {
      draw();
    }

    override bool update() {
      return updated;
    }

    override void draw() {
      // fill display matrix

      writeln(format("X: %d, Y: %d, Z: %d", coors.x, coors.y, coors.z));
      writeln(format("Chunk: %d / Cluster loaded: %d / Chunks loaded: %d / Cubes loaded: %d",
                     world.getChunkByCoordinates(coors),
                     world.clustersLoaded(),
                     world.chunksLoaded(),
                     world.cubesLoaded()
                     ));

      auto cube = world.getCube(coors);
      auto item = cube.getItem();
      if (item != null) {
         writeln(format("Item: %s", item.get.getName()));
      } else {
         writeln(format("Wall: %s / Floor: %s", cube.wall, cube.floor));
      }

      int column = 32;
      int row = 8;
      for (int j = -row; j < row; j++) {
        for (int i = -column; i < column; i++) {
          auto w = 'x';
          if (i != 0 || j != 0) {
            cube = world.getCube(GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z));
            auto glyph = new Glyph(cube);
            w = glyph.display();
          }
          write(w);
        }
        write("\n");
      }
    }
}
