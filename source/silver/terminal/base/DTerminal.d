module silver.terminal.base.DTerminal;

import silver.terminal.base.ITerminal;
import silver.terminal.base.Char;
import silver.terminal.base.Key;
import silver.terminal.base.TerminalColor;

import silver.terminal.AbstractComponent;

// D terminal
class DTerminal : ITerminal {
  import arsd.terminal;
  Terminal terminal;
  AbstractComponent component;
  Char[] glyphs;
  this(AbstractComponent component = null) {
    this.terminal = Terminal(ConsoleOutputType.linear);
    this.component = component;
    int width = this.width();
    int height = this.height();
    glyphs = new Char[width * height];
  }

  ~this() {
  }

  Key readKey() {
    auto input = RealTimeConsoleInput(&terminal, ConsoleInputFlags.raw);
  	auto ch = input.getch();
    return new Key(ch);
  }

  static Color getColor(TerminalColor color) {
    if (color == TerminalColor.BLACK) {
      return Color.black;
    }
    if (color == TerminalColor.RED) {
      return Color.red;
    }
    if (color == TerminalColor.GREEN) {
      return Color.green;
    }
    if (color == TerminalColor.YELLOW) {
      return Color.yellow;
    }
    if (color == TerminalColor.BLUE) {
      return Color.blue;
    }
    if (color == TerminalColor.MAGENTA) {
      return Color.magenta;
    }
    if (color == TerminalColor.CYAN) {
      return Color.cyan;
    }
    if (color == TerminalColor.WHITE) {
      return Color.white;
    }
    if (color == TerminalColor.GRAY) {
      return Color.white; // black + bright ?
    }
    if (color == TerminalColor.LIGHT_RED) {
      return Color.red;
    }
    if (color == TerminalColor.LIGHT_GREEN) {
      return Color.green;
    }
    if (color == TerminalColor.LIGHT_YELLOW) {
      return Color.yellow;
    }
    if (color == TerminalColor.LIGHT_BLUE) {
      return Color.blue;
    }
    if (color == TerminalColor.LIGHT_MAGENTA) {
      return Color.magenta;
    }
    if (color == TerminalColor.LIGHT_CYAN) {
      return Color.cyan;
    }
    if (color == TerminalColor.BRIGHT_WHITE) {
      return Color.white;
    }

    /* GRAY,
    LIGHT_RED,
    LIGHT_GREEN,
    LIGHT_YELLOW,
    LIGHT_BLUE,
    LIGHT_MAGENTA,
    LIGHT_CYAN,
    BRIGHT_WHITE, */
    return Color.DEFAULT;
  }

  void put(int y, int x, Char glyph) {
    /* terminal.moveTo(x, y);
    terminal.color(getColor(glyph.foreground), getColor(glyph.background));
    terminal.write(glyph.ch);
    terminal.color(Color.DEFAULT, Color.DEFAULT); */
    glyphs[x + y * width] = glyph;
  }

  void puts(int y, int x, string str) {
    auto length = str.length;
    for (int i = 0; i < length; i++) {
      glyphs[x + i + y * width] = Char(str[i]);
    }
  }

  void puts(int y, int x, string str, TerminalColor color) {

  }

  void update() {
    terminal.moveTo(0, 0);
    /* terminal.clear(); */

    int width = width();
    int height = height();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        auto glyph = glyphs[x + y*width];
        terminal.color(getColor(glyph.foreground), getColor(glyph.background));
        terminal.write(glyph.ch);
        glyphs[x + y*width] = Char(' ');
      }
      terminal.write('\n');
    }
    terminal.reset();
    terminal.flush();
  }

  int width() {
    return terminal.width;
  }

  int height() {
    return terminal.height - 1;
  }
}
