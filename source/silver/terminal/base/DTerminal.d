module silver.terminal.base.DTerminal;

import silver.terminal.base.ITerminal;
import silver.terminal.base.Char;
import silver.terminal.base.Key;
import silver.terminal.base.TerminalColor;

import silver.terminal.AbstractComponent;

// D terminal
class DTerminal : ITerminal {
  AbstractComponent component;
  this(AbstractComponent component = null) {
    this.component = component;
  }

  ~this() {

  }

  Key readKey() {
    import core.stdc.stdio: getchar;
    int keycode = getchar();
    return new Key(keycode);
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
