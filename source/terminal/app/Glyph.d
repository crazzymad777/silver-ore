module terminal.app.Glyph;
import core.world.Cube;

class Glyph {
    char glyph;
    this(Cube cube) {
      auto item = cube.getItem();
      if (item is null) {
        glyph = getCubeGlyph(cube);
      } else {
        glyph = 'o';
      }
    }

    char getCubeGlyph(Cube cube) {
      if (cube.wall.name == "AIR") {
        if (cube.floor.name == "GRASS") {
          return ',';
        } else if (cube.floor.name == "WOOD") {
          return '_';
        }
        return getGlyph(cube.floor.name);
      }

      if (cube.wall.name == "WOOD") {
        return '+';
      }
      return getGlyph(cube.wall.name);
    }

    char getGlyph(string str) {
      if (str == "GRASS") {
          return 'g';
      } else if (str == "WOOD") {
          return 'w';
      } else if (str == "STONE") {
          return 'S';
      } else if (str == "SOIL") {
          return 's';
      } else if (str == "AIR") {
          return ' ';
      } else if (str == "VOID") {
          return '!';
      } else if (str == "WATER") {
          return '~';
      } else if (str == "SILT") {
          return 'z';
      } else if (str == "SAND") {
          return '.';
      }
      return ' ';
    }

    char display() {
      return glyph;
    }
}
