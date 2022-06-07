module terminal.base.NcTerminal;
import terminal.base.ITerminal;

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

  void println(string str) {
    window.insert(str);
    window.insertln();
  }

  void putchar(char ch) {
    auto str = format("%c", ch);
    window.insert(str);
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
