module terminal.base.NcTerminal;
import terminal.base.TerminalColor;
import terminal.base.ITerminal;
import terminal.base.Char;

import core.stdc.stdio;
import nice.curses;
import std.format;

class NcTerminal : ITerminal {
  private Window window;
  private Curses curses;
  this() {
    Curses.Config cfg = {
        true,
        true,
        true, /* disable echo */
        Curses.Mode.raw
    };
    curses = new Curses(cfg);
    window = curses.stdscr;
  }

  ~this() {
    destroy(curses);
  }

  ulong getColorPair(Char glyph) {
    auto colors = curses.colors;
    auto color = colors[glyph.foreground, glyph.background];
    return color;
  }

  CChar getCChar(Char glyph) {
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
    window.refresh();
    curses.update();
  }

  import terminal.base.Key;
  Key readKey() {
    return new Key(window.getch());
  }
}
