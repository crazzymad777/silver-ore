module terminal.MapComponent;
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

class MapComponent : AbstractComponent {
    import core.world.World;
    import core.world.map.ClusterId;
    import core.world.map.Tile;

    private World world;
    ClusterId clusterId;
    private auto updated = true;
    private auto exited = false;
    private ITerminal terminal;

    this(ITerminal terminal, World world) {
       this.world = world;
       this.terminal = terminal;
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
      dchar c = to!dchar(key.getKeycode());
      if (c == 'q') {
        exited = true;
      } else if (c == 'w') {
        clusterId.setY(clusterId.getSignedY() - 1);
      } else if (c == 's') {
        clusterId.setY(clusterId.getSignedY() + 1);
      } else if (c == 'a') {
        clusterId.setX(clusterId.getSignedX() - 1);
      } else if (c == 'd') {
        clusterId.setX(clusterId.getSignedX() + 1);
      } else if (c == 'c') {
        world.clearBiomes();
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
      terminal.puts(offset + 0, 0, format("ClusterId(sX: %d, sY: %d, X: %d, Y: %d)",
      clusterId.getSignedX(), clusterId.getSignedY(),
      clusterId.getUnsignedX(), clusterId.getUnsignedY()
      ));
      terminal.puts(offset + 1, 0, format("Biomes loaded: %d / Cluster loaded: %d",
                     world.biomesLoaded(),
                     world.clustersLoaded()
                     ));

      auto biomeId = world.getBiomeId(clusterId);
      terminal.puts(offset + 2, 0, format("BiomeId: %d, %d", biomeId.x, biomeId.y));

      int column = terminal.width()/2;
      int row = (terminal.height()-4)/2;
      for (int j = -row; j < row; j++) {
        for (int i = -column; i < column; i++) {
          auto w = 'x';
          auto color = TerminalColor.WHITE;
          if (i != 0 || j != 0) {
            auto x = clusterId.getSignedX() + i;
            auto y = clusterId.getSignedY() + j;
            Tile tile = world.getTile(signedClusterId(x, y));
            if (tile.type == Tile.TYPE.SEA) {
              color = TerminalColor.CYAN;
              w = '~';// 's';
            } else if (tile.type == Tile.TYPE.TOWN) {
              color = TerminalColor.YELLOW;
              w = 'T';
            } else if (tile.type == Tile.TYPE.FLAT) {
              color = TerminalColor.GREEN;
              w = '_'; //'f';
            } else if (tile.type == Tile.TYPE.DESERT) {
              color = TerminalColor.YELLOW;
              w = '_'; //'f';
            } else if (tile.type == Tile.TYPE.FOREST) {
              color = TerminalColor.GREEN;
              w = 'F';
            }
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
