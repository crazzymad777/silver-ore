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
        // false, /* disable nice curses color table init */
        true,
        true, /* disable echo */
        Curses.Mode.raw
    };
    curses = new Curses(cfg);
    window = curses.stdscr;

    // init color table
    /* import std.traits;
    foreach (colorA; EnumMembers!TerminalColor) {
        foreach (colorB; EnumMembers!TerminalColor) {
          try {
            curses.colors.addPair(colorA, colorB);
          } catch (NCException e) {

          }
        }
    } */
  }

  ~this() {
    destroy(curses);
  }

  ulong getColorPair(Char* glyph) {
    auto colors = curses.colors;
    auto color = colors[glyph.foreground, glyph.background];
    /* auto color = 256 + glyph.foreground*2048 + glyph.background*256; */
    return color;
  }

  CChar getCChar(Char* glyph) {
    return CChar(glyph.ch, getColorPair(glyph));
  }

  void put(int y, int x, Char glyph) {
    try {
      window.addch(y, x, getCChar(&glyph));
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
    window.refresh();
    curses.update();
    window.clear();
  }

  import terminal.base.Key;
  Key readKey() {
    return new Key(window.getch());
  }
}
