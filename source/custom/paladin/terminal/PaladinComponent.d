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
      game.process();
    }

    bool showTicks = false;
    override void recvKey(Key key) {
      // handle key
      dchar c = to!dchar(key.getKeycode());

      bool prepend = false;
      if (c == 'q') {
        /* game.apocalypse(); */
        exited = true;
      } else if (c == 'w') {
        game.getPaladin().move(0, -1);
        prepend = true;
      } else if (c == 's') {
        game.getPaladin().move(0, 1);
        prepend = true;
      } else if (c == 'a') {
        game.getPaladin().move(-1);
        prepend = true;
      } else if (c == 'd') {
        game.getPaladin().move(1);
        prepend = true;
      } else if (c == '0') {
        showTicks = !showTicks;
        prepend = true;
      } else if (c == 'f') {
        game.follow();
        prepend = true;
      } else if (c == 'p') {
        game.getPaladin().attack();
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
        Animal hero = cast(Animal) game.getPaladin();
        auto coors = hero.position;

        import core.game.Mob;
        import core.game.animals.Animal;
        import core.game.animals.Lion;
        import core.game.monsters.Monster;

        auto mobs = game.getMobs();

        if (showTicks) terminal.puts(0, width + 1, format("World tick: %d / Cubes loaded: %d", game.count, game.world.cubesLoaded()));

        import std.utf;
        string t;
        if (sequence.length > width) {
          t = sequence[sequence.stride() .. width];
        } else {
          t = sequence;
        }
        terminal.puts(0, width + 1, format("%s", t));
        int k = 0;
        foreach(entry; game.stats.entries.byKeyValue()) {
          terminal.puts(2 + k*5, width + width/2 + 1,
                        format("%s", entry.key));
          terminal.puts(3 + k*5, width + width/2 + 1,
                        format(" - Damage: %d", entry.value.damage));
          terminal.puts(4 + k*5, width + width/2 + 1,
                        format(" - Hits: %d", entry.value.hits));
          terminal.puts(5 + k*5, width + width/2 + 1,
                        format(" - Taken hits: %d", entry.value.hitsTaken));
          terminal.puts(6 + k*5, width + width/2 + 1,
                        format(" - Taken damage: %d", entry.value.damageTaken));
          k++;
        }

        auto frens = game.getMobs();
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
                           format("+ %s", game.textState.getStamina(fren.stamina, fren.maxStamina)),
                           game.textState.getStaminaColor(fren.stamina, fren.maxStamina)
                           );

          terminal.puts(4 + i*4, width + 1,
                           format("+ %s (%d)", game.textState.getHealth(fren.hitpoints, fren.maxHitpoints), fren.hitpoints),
                           game.textState.getHealthColor(fren.hitpoints, fren.maxHitpoints)
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

                if (Animal animal = cast(Animal) entity) {
                  if (animal.attackedTick + 5 > game.getTick()) {
                    color = TerminalColor.MAGENTA;
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
