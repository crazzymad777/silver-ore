module terminal.base.NcTerminal;
import terminal.base.TerminalColor;
import terminal.AbstractComponent;
import terminal.base.ITerminal;
import terminal.base.Char;

import core.stdc.stdio;
import nice.curses;
import std.format;

class NcTerminal : ITerminal {
  private Window window;
  private Curses curses;

  AbstractComponent component;
  const static KEY_RESIZE = Key.resize;
  this(AbstractComponent component = null) {
    import terminal.Settings;

    Curses.Config cfg = {
        useColors: true,
        useStdColors: !enable16colors, /* disable nice curses color table init */
        disableEcho: true, /* disable echo */
        mode: Curses.Mode.raw,
        cursLevel: 0
    };
    curses = new Curses(cfg);
    window = curses.stdscr;
    window.timeout(100);

    // init color table
    static if (enable16colors) {
      import std.traits;
      foreach (colorA; EnumMembers!TerminalColor) {
          foreach (colorB; EnumMembers!TerminalColor) {
            try {
              curses.colors.addPair(colorA, colorB);
            } catch (NCException e) {

            }
          }
      }
    }

    this.component = component;
  }

  ~this() {
    destroy(curses);
  }

  ulong getColorPair(const ref Char glyph) {
    auto colors = curses.colors;
    auto color = colors[glyph.foreground, glyph.background];
    /* auto color = 256 + glyph.foreground*2048 + glyph.background*256; */
    return color;
  }

  CChar getCChar(const ref Char glyph) {
    return CChar(glyph.ch, getColorPair(glyph));
  }

  void put(int y, int x, Char glyph) {
    try {
      window.addch(y, x, getCChar(glyph));
    } catch (NCException e) {

    }
  }

  void puts(int y, int x, string str) {
    try {
      window.addstr(y, x, str);
    } catch (NCException e) {

    }
  }

  void update() {
    /* puts(0, 0, format("%d", getColorPair(Char('x', TerminalColor.GRAY)))); */
    /* window.refresh(); */
    /* curses.update(); */

    // with window clear tty is blinking
    window.clear();
  }

  import Terminal = terminal.base.Key;
  Terminal.Key readKey() {
    try {
      auto key = window.getch();
      if (key == KEY_RESIZE) {
        if (component !is null) {
          component.resize(window.width(), window.height());
        }
        return new Terminal.Key();
      }
      return new Terminal.Key(key);
    } catch (NCException e) {
      return new Terminal.Key();
    }
  }

  int width() {
    return window.width();
  }

  int height() {
    return window.height();
  }
}
