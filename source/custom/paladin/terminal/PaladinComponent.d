module custom.paladin.terminal.PaladinComponent;

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
import custom.paladin.world.World;
import core.world.WorldConfig;

class PaladinComponent : AbstractComponent {
    private World world;
    private auto updated = true;
    private auto exited = false;
    private ITerminal terminal;

    this() {
      import terminal.Settings: enableNcTerminal;
      ITerminal terminal = ITerminal.getDefaultTerminal(!enableNcTerminal, this);

      this.world = new World();
      this.terminal = terminal;
      /* this.coors = world.getDefaultCoordinates(); */
    }

    ~this() {
      /* Hm, without this line there is Segmentation fault after 'q' */
      destroy(terminal);
    }

    // obtain key
    override Key read() {
      return terminal.readKey();
    }

    override bool closed() {
      return exited;
    }

    override void process() {
      world.process();
    }

    override void recvKey(Key key) {
      // handle key
      dchar c = to!dchar(key.getKeycode());
      if (c == 'q') {
        world.apocalypse();
        exited = true;
      } else if (c == 'w') {
        /* coors.y--; */
        world.getPaladin().move(0, -1);
      } else if (c == 's') {
        /* coors.y++; */
        world.getPaladin().move(0, 1);
      } else if (c == 'a') {
        /* coors.x--; */
        world.getPaladin().move(-1);
      } else if (c == 'd') {
        /* coors.x++; */
        world.getPaladin().move(1);
      }
    }

    override void resize(int width, int height) {
      /* draw(); */
    }

    override bool update() {
      return updated;
    }

    override void sync() {
      terminal.update();
    }

    override void draw() {
        // fill display matrix


        /* terminal.puts(offset + 0, 0, format("X: %d, Y: %d, Z: %d", coors.x, coors.y, coors.z)); */
        /* terminal.puts(offset + 1, 0, format("Cluster loaded: %d / Chunks loaded: %d / Cubes loaded: %d",
                       world.clustersLoaded(),
                       world.chunksLoaded(),
                       world.cubesLoaded()
                       )); */

        auto hero = world.getPaladin();
        auto coors = hero.position;
        auto cube = world.getCube(coors);
        auto item = cube.getItem();
        /* if (item !is null) {
           terminal.puts(offset + 2, 0, format("Item: %s", item.getName()));
        } else {
           terminal.puts(offset + 2, 0, format("Wall: %s / Floor: %s", cube.wall, cube.floor));
        } */
        terminal.puts(0, terminal.width()*2/3 + 1, format("World tick: %d / Cubes loaded: %d", world.count, world.cubesLoaded()));
        terminal.puts(1, terminal.width()*2/3 + 1, format("Your stamina: %d/%d", hero.stamina, hero.maxStamina));
        terminal.puts(2, terminal.width()*2/3 + 1, format("Your HP: %d/%d", hero.hitpoints, hero.maxHitpoints));

        int column = (terminal.width()*2/3)/2;
        int row = (terminal.height())/2;
        for (int j = -row; j < row; j++) {
          for (int i = -column; i < column; i++) {
            auto w = 'x';
            auto color = TerminalColor.WHITE;
            auto lookAt = GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z);
            if (world.checkVisible(hero.position, lookAt)) {
              if (i != 0 || j != 0) {
                cube = world.getCube(lookAt);
                auto glyph = new Glyph(cube);
                w = glyph.display();
                color = glyph.foreground;
              } else {
                color = TerminalColor.RED;
                w = 'P';
              }
            } else {
              color = TerminalColor.BLACK;
              w = ' ';
            }
            terminal.put(j + row, i + column, Char(w, color, TerminalColor.BLACK));
            /* terminal.putchar(w); */
          }
          /* terminal.putchar('\n'); */
        }
    }

}
