module terminal.base.ITerminal;
import terminal.base.Key;

interface ITerminal {
  Key readKey();
  void println(string str);
  void putchar(char ch);
  void update();
}
