module terminal.base.NcTerminal;
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

  void put(int y, int x, Char glyph) {
    try {
      window.addch(y, x, glyph.ch);
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
    window.clear();
  }

  import terminal.base.Key;
  Key readKey() {
    return new Key(window.getch());
  }
}
