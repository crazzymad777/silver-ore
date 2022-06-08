module terminal.base.Char;

import terminal.base.TerminalColor;

struct Char {
  dchar ch;
  TerminalColor foreground = TerminalColor.WHITE;
  TerminalColor background = TerminalColor.BLACK;
}
