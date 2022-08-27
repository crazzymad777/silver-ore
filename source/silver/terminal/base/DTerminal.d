module silver.terminal.base.DTerminal;

import silver.terminal.base.TerminalMatrix;
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
  TerminalMatrix matrix;
  int oldwidth, oldheight;
  this(AbstractComponent component = null) {
    this.terminal = Terminal(ConsoleOutputType.linear);
    this.component = component;

    int width = terminal.width();
    int height = terminal.height();
    matrix = new TerminalMatrix();
    matrix.resize(width, height);
    oldwidth = width;
    oldheight = height;
  }

  ~this() {
  }

  protected bool checkSize() {
    int width = terminal.width();
    int height = terminal.height();

    bool changed = false;
    if (oldwidth != width) {
      oldwidth = width;
      changed = true;
    }
    if (oldheight != height) {
      oldheight = height;
      changed = true;
    }
    if (changed) {
      matrix.resize(width, height);
    }
    return changed;
  }

  Key readKey() {
    auto input = RealTimeConsoleInput(&terminal, ConsoleInputFlags.raw + ConsoleInputFlags.size);
    input.timedCheckForInput(100);
    checkSize();
  	auto ch = input.getch(true);
    return new Key(ch);
  }

  static int getColor(TerminalColor color) {
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
      return Color.black | Bright;
    }
    if (color == TerminalColor.LIGHT_RED) {
      return Color.red | Bright;
    }
    if (color == TerminalColor.LIGHT_GREEN) {
      return Color.green | Bright;
    }
    if (color == TerminalColor.LIGHT_YELLOW) {
      return Color.yellow | Bright;
    }
    if (color == TerminalColor.LIGHT_BLUE) {
      return Color.blue | Bright;
    }
    if (color == TerminalColor.LIGHT_MAGENTA) {
      return Color.magenta | Bright;
    }
    if (color == TerminalColor.LIGHT_CYAN) {
      return Color.cyan | Bright;
    }
    if (color == TerminalColor.BRIGHT_WHITE) {
      return Color.white | Bright;
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
    matrix.put(y, x, glyph);
  }

  void puts(int y, int x, string str) {
    matrix.puts(y, x, str);
  }

  void puts(int y, int x, string str, TerminalColor color) {
    matrix.puts(y, x, str, color);
  }

  void update() {
    terminal.moveTo(0, 0);
    /* terminal.clear(); */

    int width = width();
    int height = height();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        auto glyph = matrix.get(y, x);
        terminal.color(getColor(glyph.foreground), getColor(glyph.background));
        terminal.write(glyph.ch);
        matrix.put(y, x, Char());
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
