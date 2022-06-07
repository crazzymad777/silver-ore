module terminal.base.ITerminal;
import terminal.base.NcTerminal;
import terminal.base.Key;

interface ITerminal {
  Key readKey();
  void println(string str);
  void putchar(char ch);
  void update();

  static ITerminal getDefaultTerminal() {
    return new NcTerminal();
  }
}
