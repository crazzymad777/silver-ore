module terminal.base.Char;

import terminal.base.RgbColor;

struct Char {
  dchar ch;
  RgbColor foreground = RgbColor(255, 255, 255);
  RgbColor background = RgbColor(0, 0, 0);
}
