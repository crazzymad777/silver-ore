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

    bool showTicks = false;
    override void recvKey(Key key) {
      // handle key
      dchar c = to!dchar(key.getKeycode());
      if (c == 'q') {
        world.apocalypse();
        exited = true;
      } else if (c == 'w') {
        world.getPaladin().move(0, -1);
      } else if (c == 's') {
        world.getPaladin().move(0, 1);
      } else if (c == 'a') {
        world.getPaladin().move(-1);
      } else if (c == 'd') {
        world.getPaladin().move(1);
      } else if (c == '0') {
        showTicks = !showTicks;
      } else if (c == 'f') {
        world.follow();
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

        auto hero = world.getPaladin();
        auto coors = hero.position;

        import core.game.Mob;
        import core.game.animals.Animal;
        import core.game.animals.Lion;
        import core.game.monsters.Monster;

        auto mobs = world.getMobs();

        if (showTicks) terminal.puts(0, terminal.width()*2/3 + 1, format("World tick: %d / Cubes loaded: %d", world.count, world.cubesLoaded()));

        terminal.puts(2, terminal.width()*2/3 + 1,
                      format("You're %s", hero.getName()));

        terminal.puts(3, terminal.width()*2/3 + 1,
                      format("You're in %s...", "the Dark Maze of Dungeon"));

        terminal.puts(4, terminal.width()*2/3 + 1,
                         format("%s", world.textState.getStamina(hero.stamina, hero.maxStamina)),
                         world.textState.getStaminaColor(hero.stamina, hero.maxStamina)
                         );
        terminal.puts(5, terminal.width()*2/3 + 1,
                         format("%s", world.textState.getHealth(hero.hitpoints, hero.maxHitpoints)),
                         world.textState.getHealthColor(hero.hitpoints, hero.maxHitpoints)
                         );

        auto frens = world.friends();
        for (int i = 0; i < frens.length; i++) {
          auto fren = frens[i];
          terminal.puts(6 + i*5, terminal.width()*2/3 + 1,
                        format("Your friend is %s", fren.getName()));

          terminal.puts(7 + i*5, terminal.width()*2/3 + 1,
                        format("They're in %s...", "the Dark Maze of Dungeon"));

          terminal.puts(8 + i*5, terminal.width()*2/3 + 1,
                           format("%s", world.textState.getStamina(fren.stamina, fren.maxStamina)),
                           world.textState.getStaminaColor(fren.stamina, fren.maxStamina)
                           );

          terminal.puts(9 + i*5, terminal.width()*2/3 + 1,
                           format("%s", world.textState.getHealth(fren.hitpoints, fren.maxHitpoints)),
                           world.textState.getHealthColor(fren.hitpoints, fren.maxHitpoints)
                           );

           if (cast(Animal) fren) {
             Animal animal = cast(Animal) fren;
             if (animal.followed !is null) {
               terminal.puts(10 + i*5, terminal.width()*2/3 + 1,
                                format("They follow %s", animal.followed != hero ? animal.followed.getName() : "you")
                                );
             }
           }
        }

        int column = (terminal.width()*2/3)/2;
        int row = (terminal.height())/2;
        for (int j = -row; j < row; j++) {
          for (int i = -column; i < column; i++) {
            auto w = 'x';
            auto color = TerminalColor.WHITE;
            auto lookAt = GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z);
            if (world.checkVisible(hero.position, lookAt)) {
              Mob entity;
              foreach (mob; mobs) {
                if (mob.position == lookAt) {
                  entity = mob;
                  break;
                }
              }

              if (entity is null) {
                auto cube = world.getCube(lookAt);
                auto glyph = new Glyph(cube);
                w = glyph.display();
                color = glyph.foreground;
              } else {
                w = entity.getName()[0];
                color = TerminalColor.WHITE;
                if (entity == hero) {
                  color = TerminalColor.WHITE;
                } else if (cast(Monster) entity) {
                  color = TerminalColor.RED;
                } else if (cast(Lion) entity) {
                  color = TerminalColor.YELLOW;
                }
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
