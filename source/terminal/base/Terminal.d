module terminal.base.Terminal;
import terminal.base.ITerminal;
import terminal.base.Key;

import core.stdc.stdio;

class Terminal : ITerminal {
  Key readKey() {
    return new Key(getchar());
  }
}
