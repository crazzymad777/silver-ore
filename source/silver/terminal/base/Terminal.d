module silver.terminal.base.Terminal;

import silver.terminal.base.ITerminal;
import silver.terminal.base.Char;
import silver.terminal.base.Key;
import silver.terminal.base.TerminalColor;

import silver.terminal.AbstractComponent;

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
