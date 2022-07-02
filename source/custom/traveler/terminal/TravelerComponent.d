module custom.traveler.terminal.TravelerComponent;

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

class TravelerComponent : AbstractComponent {
    import custom.traveler.TravelerController;
    private ITravelerController controller;
    private auto updated = true;
    private auto exited = false;
    private ITerminal terminal;

    this() {
      import terminal.Settings: enableNcTerminal;
      ITerminal terminal = ITerminal.getDefaultTerminal(!enableNcTerminal, this);

      this.controller = ITravelerController.getImplementation();
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
      controller.process();
    }

    bool showTicks = false;
    override void recvKey(Key key) {
      // handle key
      dchar c = to!dchar(key.getKeycode());

      bool prepend = false;
      if (c == 'r') {
        controller.resetGame();
      } if (c == 'q') {
        /* game.apocalypse(); */
        exited = true;
      } else if (c == 'w') {
        controller.move(0, -1);
        prepend = true;
      } else if (c == 's') {
        controller.move(0, 1);
        prepend = true;
      } else if (c == 'a') {
        controller.move(-1);
        prepend = true;
      } else if (c == 'd') {
        controller.move(1);
        prepend = true;
      } else if (c == '0') {
        showTicks = !showTicks;
        prepend = true;
      } else if (c == 'f') {
        controller.follow();
        prepend = true;
      } else if (c == 'p') {
        controller.attack();
        prepend = true;
      }

      if (prepend || key.getKeycode() == 0) {
        import std.conv: to;
        if (key.getKeycode() == 0) {
          c = ' ';
        }
        sequence = to!string(c) ~ sequence;
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

    string sequence;
    override void draw() {
        // fill display matrix
        int width = terminal.width()*1/2;
        import core.game.animals.Animal;
        Animal hero = cast(Animal) controller.getTraveler();
        auto coors = hero.position;

        import core.game.Mob;
        import core.game.animals.Animal;
        import core.game.animals.Lion;
        import core.game.monsters.Monster;

        auto mobs = controller.getMobs();

        if (showTicks) terminal.puts(0, width + 1, format("World tick: %d / Cubes loaded: %d", controller.count(), controller.cubesLoaded()));

        import std.utf;
        string t;
        if (sequence.length > width) {
          t = sequence[sequence.stride() .. width];
        } else {
          t = sequence;
        }
        terminal.puts(0, width + 1, format("%s", t));

        auto glyph = new Glyph(controller.getWorld());
        int column = width;
        int row = (terminal.height())/2;
        for (int j = -row; j <= row; j++) {
          for (int i = -column; i < column; i++) {
            auto w = 'x';
            auto color = TerminalColor.BLACK;
            auto lookAt = GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z);
            glyph.newGlyph(lookAt);

            import std.math: abs;
            if (row-abs(j) >= 3 && column-abs(i) >= 3) {
              if (controller.checkVisible(hero.position, lookAt) || !hero.isAlive() || controller.endCondition()) {
                Mob entity;
                foreach (mob; mobs) {
                  if (mob.position == lookAt) {
                    entity = mob;
                    break;
                  }
                }

                if (entity is null) {
                  auto cube = controller.getCube(lookAt);

                  w = glyph.display();
                  color = glyph.foreground;
                } else {
                  w = entity.getName()[0];
                  color = TerminalColor.WHITE;
                  if (entity.isAlive()) {
                    if (entity == hero) {
                      color = TerminalColor.WHITE;
                    } else if (cast(Monster) entity) {
                      color = TerminalColor.RED;
                    } else if (cast(Lion) entity) {
                      color = TerminalColor.YELLOW;
                    }
                  }

                  if (Animal animal = cast(Animal) entity) {
                    if (animal.attackedTick + 5 > controller.getTick()) {
                      color = TerminalColor.MAGENTA;
                    }
                  }
                }
              } else {
                color = TerminalColor.BLACK;
                w = ' ';
              }
            } else {
              if (hero.attackedTick + 5 > controller.getTick()) {
                color = TerminalColor.RED;
              }
            }
            terminal.put(j + row, i + column, Char(w, color, TerminalColor.BLACK));
          }
        }
    }

}