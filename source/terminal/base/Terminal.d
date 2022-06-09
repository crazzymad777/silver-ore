module terminal.base.Terminal;

import terminal.base.ITerminal;
import terminal.base.Char;
import terminal.base.Key;

// stub terminal
class Terminal : ITerminal {
  Key readKey() {
    return new Key();
  }

  void put(int y, int x, Char glyph) {

  }

  void puts(int y, int x, string str) {

  }

  void update() {

  }
}
