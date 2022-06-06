module terminal.base.ITerminal;
import terminal.base.Key;

interface ITerminal {
  Key readKey();
}
