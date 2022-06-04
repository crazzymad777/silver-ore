module terminal.GameComponent;
import terminal.AbstractComponent;
import terminal.base.Key;

import std.stdio;

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

      int column = 32;
      int row = 16;
      for (int j = -row; j < row; j++) {
        for (int i = -column; i < column; i++) {
          auto cube = world.getCube(GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z));
          write(cube.item.display());
        }
        write("\n");
      }
    }
}
