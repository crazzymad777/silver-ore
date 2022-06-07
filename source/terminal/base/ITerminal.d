module terminal.base.ITerminal;
import terminal.base.NcTerminal;
import terminal.base.Char;
import terminal.base.Key;

interface ITerminal {
  Key readKey();
  void put(int y, int x, Char glyph);
  void puts(int y, int x, string str);
  void update();

  static ITerminal getDefaultTerminal() {
    return new NcTerminal();
  }
}
