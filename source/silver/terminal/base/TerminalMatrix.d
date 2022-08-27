module silver.terminal.base.TerminalMatrix;

import silver.terminal.base.TerminalColor;
import silver.terminal.base.Char;

class TerminalMatrix {
  protected int width;
  protected int height;
  protected Char[] glyphs;

  this() {
    glyphs = new Char[width * height];
  }

  Char get(int y, int x) {
    if (x >= 0 && x < width) {
      if (y >= 0 && y < height) {
        return glyphs[x + y * width];
      }
    }
    return Char();
  }

  void resize(int width, int height) {
    this.width = width;
    this.height = height;
    glyphs = new Char[width * height];
  }

  void put(int y, int x, Char glyph) {
    if (x >= 0 && x < width) {
      if (y >= 0 && y < height) {
        glyphs[x + y * width] = glyph;
      }
    }
  }

  void puts(int y, int x, string str) {
    if (y >= 0 && y < height) {
      auto length = str.length;
      for (int i = 0; i < length; i++) {
        glyphs[x + i + y * width] = Char(str[i]);
      }
    }
  }

  void puts(int y, int x, string str, TerminalColor color) {
    if (y >= 0 && y < height) {
      auto length = str.length;
      for (int i = 0; i < length; i++) {
        glyphs[x + i + y * width] = Char(str[i], color);
      }
    }
  }
}
