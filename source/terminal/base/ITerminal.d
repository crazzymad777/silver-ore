module terminal.base.ITerminal;
import terminal.base.NcTerminal;
import terminal.base.Terminal;
import terminal.base.Char;
import terminal.base.Key;
import terminal.base.TerminalColor;

import terminal.AbstractComponent;

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
    return new NcTerminal(component);
  }
}
