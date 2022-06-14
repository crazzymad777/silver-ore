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
import custom.paladin.core.Game;
import core.world.WorldConfig;

class PaladinComponent : AbstractComponent {
    private Game game;
    private auto updated = true;
    private auto exited = false;
    private ITerminal terminal;

    this() {
      import terminal.Settings: enableNcTerminal;
      ITerminal terminal = ITerminal.getDefaultTerminal(!enableNcTerminal, this);

      this.game = new Game();
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
      game.world.process();
    }

    bool showTicks = false;
    override void recvKey(Key key) {
      // handle key
      dchar c = to!dchar(key.getKeycode());
      if (c == 'q') {
        game.world.apocalypse();
        exited = true;
      } else if (c == 'w') {
        game.world.getPaladin().move(0, -1);
      } else if (c == 's') {
        game.world.getPaladin().move(0, 1);
      } else if (c == 'a') {
        game.world.getPaladin().move(-1);
      } else if (c == 'd') {
        game.world.getPaladin().move(1);
      } else if (c == '0') {
        showTicks = !showTicks;
      } else if (c == 'f') {
        game.world.follow();
      } else if (c == 'p') {
        game.world.getPaladin().attack();
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
        int width = terminal.width()*1/2;
        import core.game.animals.Animal;
        Animal hero = cast(Animal) game.world.getPaladin();
        auto coors = hero.position;

        import core.game.Mob;
        import core.game.animals.Animal;
        import core.game.animals.Lion;
        import core.game.monsters.Monster;

        auto mobs = game.world.getMobs();

        if (showTicks) terminal.puts(0, terminal.width()*2/3 + 1, format("World tick: %d / Cubes loaded: %d", game.world.count, game.world.cubesLoaded()));

        terminal.puts(2, width + 1,
                      format("You're %s", hero.getName()));

        terminal.puts(3, width + 1,
                         format("+ %s", game.world.textState.getStamina(hero.stamina, hero.maxStamina)),
                         game.world.textState.getStaminaColor(hero.stamina, hero.maxStamina)
                         );
        terminal.puts(4, width + 1,
                         format("+ %s", game.world.textState.getHealth(hero.hitpoints, hero.maxHitpoints)),
                         game.world.textState.getHealthColor(hero.hitpoints, hero.maxHitpoints)
                         );

        auto frens = game.world.getMobs();
        for (int i = 0; i < frens.length; i++) {
          if (frens[i] !is null) {
          auto fren = frens[i];
          if (fren == hero) {
            terminal.puts(2 + i*4, width + 1,
                          format("You're %s", hero.getName()));
          } else {
            terminal.puts(2 + i*4, width + 1,
                          format("Your %s is %s", hero.isFoe(fren) ? "foe" : "friend", fren.getName()));
          }

          terminal.puts(3 + i*4, width + 1,
                           format("+ %s", game.world.textState.getStamina(fren.stamina, fren.maxStamina)),
                           game.world.textState.getStaminaColor(fren.stamina, fren.maxStamina)
                           );

          terminal.puts(4 + i*4, width + 1,
                           format("+ %s (%d)", game.world.textState.getHealth(fren.hitpoints, fren.maxHitpoints), fren.hitpoints),
                           game.world.textState.getHealthColor(fren.hitpoints, fren.maxHitpoints)
                           );

           if (cast(Animal) fren) {
             Animal animal = cast(Animal) fren;
             if (animal.followed !is null) {
               terminal.puts(5 + i*4, width + 1,
                                format("+ They follow %s", animal.followed != hero ? animal.followed.getName() : "you")
                                );
             }
           }
          }
        }

        int column = (width)/2;
        int row = (terminal.height())/2;
        for (int j = -row; j < row; j++) {
          for (int i = -column; i < column; i++) {
            auto w = 'x';
            auto color = TerminalColor.WHITE;
            auto lookAt = GlobalCubeCoordinates(coors.x + i, coors.y + j, coors.z);
            if (game.world.checkVisible(hero.position, lookAt) || !hero.isAlive()) {
              Mob entity;
              foreach (mob; mobs) {
                if (mob.position == lookAt) {
                  entity = mob;
                  break;
                }
              }

              if (entity is null) {
                auto cube = game.world.getCube(lookAt);
                auto glyph = new Glyph(cube);
                w = glyph.display();
                color = glyph.foreground;
              } else {
                w = entity.getName()[0];
                color = TerminalColor.WHITE;
                if (entity.isAlive()) {
                  if (entity == hero) {
                    color = TerminalColor.GREEN;
                  } else if (cast(Monster) entity) {
                    color = TerminalColor.RED;
                  } else if (cast(Lion) entity) {
                    color = TerminalColor.YELLOW;
                  }
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
