module silver.terminal.base.ITerminal;

import silver.terminal.base.NcTerminal;
import silver.terminal.base.DTerminal;
import silver.terminal.base.Terminal;
import silver.terminal.base.Char;
import silver.terminal.base.Key;
import silver.terminal.base.TerminalColor;

import silver.terminal.AbstractComponent;

interface ITerminal {
  Key readKey();
  void put(int y, int x, Char glyph);
  void puts(int y, int x, string str);
  void puts(int y, int x, string str, TerminalColor color);
  void update();
  int width();
  int height();

  static ITerminal getDefaultTerminal(bool stub = false, AbstractComponent component = null) {
    if (stub) {
      return new Terminal(component);
    }
    return new DTerminal(component);
  }
}
