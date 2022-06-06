module terminal.base.NcTerminal;
import terminal.base.ITerminal;

import core.stdc.stdio;
import nice.curses;

class NcTerminal : ITerminal {
  private Window window;
  private Curses curses;
  this() {
    Curses.Config cfg = {};
    curses = new Curses(cfg);
    window = curses.newWindow(curses.lines, curses.cols, 0, 0);
  }

  ~this() {
    curses.deleteWindow(window);
    destroy(curses);
  }

  import terminal.base.Key;
  Key readKey() {
    return new Key(window.getch());
  }
}
