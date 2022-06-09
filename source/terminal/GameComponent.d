module terminal.GameComponent;
import terminal.AbstractComponent;
import terminal.base.TerminalColor;
import terminal.base.ITerminal;
import terminal.base.Char;
import terminal.base.Key;
import terminal.app.Glyph;

import std.stdio;
import std.format;
import std.conv;

import core.world.utils.GlobalCubeCoordinates;
import core.world.World;
import core.world.WorldConfig;

class GameComponent : AbstractComponent {
    private World world;
    private GlobalCubeCoordinates coors;
    private auto updated = true;
    private auto exited = false;
    private auto speed = 256;
    private ITerminal terminal;

    this(ITerminal terminal) {
       world = new World();
       this.terminal = terminal;
       this.coors = world.getDefaultCoordinates();
    }

    // obtain key
    override Key read() {
      return terminal.readKey();
    }

    override bool closed() {
      return exited;
    }

    override void process() {

    }

    override void recvKey(Key key) {
      // handle key
      char c = to!char(key.getKeycode());
      if (c == 'q') {
        exited = true;
      } else if (c == 'w') {
        coors.y--;
      } else if (c == 's') {
        coors.y++;
      } else if (c == 'a') {
        coors.x--;
      } else if (c == 'd') {
        coors.x++;
      } else if (c == 'e') {
        coors.z++;
      } else if (c == 'r') {
        coors.z--;
      }
    }

    override void resize(int width, int height) {
      draw();
    }

    override bool update() {
      return updated;
    }

    override void sync() {
      terminal.update();
    }

    override void draw() {
      // fill display matrix

      int offset = 1;
      terminal.puts(offset + 0, 0, format("X: %d, Y: %d, Z: %d", coors.x, coors.y, coors.z));
      terminal.puts(offset + 1, 0, format("Cluster loaded: %d / Chunks loaded: %d / Cubes loaded: %d",
                     world.clustersLoaded(),
                     world.chunksLoaded(),
                     world.cubesLoaded()
                     ));

      auto cube = world.getCube(coors);
      auto item = cube.getItem();
      if (item != null) {
         terminal.puts(offset + 2, 0, format("Item: %s", item.get.getName()));
      } else {
         terminal.puts(offset + 2, 0, format("Wall: %s / Floor: %s", cube.wall, cube.floor));
      }

      int column = 32;
      int row = 8;
      for (int j = -row; j < row; j++) {
        for (int i = -column; i < column; i++) {
          auto w = 'x';
          auto color = TerminalColor.WHITE;
          if (i != 0 || j != 0) {
            cube = world.getCube(GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z));
            auto glyph = new Glyph(cube);
            w = glyph.display();
          } else {
            color = TerminalColor.RED;
          }
          terminal.put(offset + 3 + j + row, i + column, Char(w, color, TerminalColor.BLACK));
          /* terminal.putchar(w); */
        }
        /* terminal.putchar('\n'); */
      }
    }
}
