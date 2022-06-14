module terminal.base.Terminal;

import terminal.base.ITerminal;
import terminal.base.Char;
import terminal.base.Key;
import terminal.base.TerminalColor;

import terminal.AbstractComponent;

// stub terminal
class Terminal : ITerminal {
  this(AbstractComponent component = null) {

  }

  ~this() {

  }

  Key readKey() {
    return new Key();
  }

  void put(int y, int x, Char glyph) {

  }

  void puts(int y, int x, string str) {

  }

  void puts(int y, int x, string str, TerminalColor color) {

  }

  void update() {

  }

  int width() {
    return 80;
  }

  int height() {
    return 60;
  }
}
