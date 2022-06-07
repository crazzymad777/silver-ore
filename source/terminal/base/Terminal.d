module terminal.base.Terminal;
import terminal.base.ITerminal;
import terminal.base.Key;

import core.stdc.stdio;
import std.stdio;

class Terminal : ITerminal {
  Key readKey() {
    return new Key(getchar());
  }

  void println(string str) {
    writeln(str);
  }

  void putchar(char ch) {
    write(ch);
  }

  void update() {

  }
}
