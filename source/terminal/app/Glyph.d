module terminal.app.Glyph;
import core.world.Cube;
import core.game.Item;
import core.game.material.Material;

import terminal.base.TerminalColor;

class Glyph {
    char glyph;
    TerminalColor foreground = TerminalColor.WHITE;
    this(Cube cube) {
      auto item = cube.getItem();
      if (item is null) {
        glyph = getCubeChar(cube);
      } else {
        glyph = getItemChar(item);
      }
    }

    char getItemChar(Item item) {
      import core.game.Ore;
      assert(item !is null);
      if (cast(Ore) item) {
        auto ore = cast(Ore) item;
        foreground = getMaterialForegroundColor(ore.metal);
        if (ore.metal.name == "GOLD") {
          return 'g';
        }
        if (ore.metal.name == "SILVER") {
          return '$';
        }
        if (ore.metal.name == "IRON") {
          return 'i';
        }
        if (ore.metal.name == "TIN") {
          return 't';
        }
        if (ore.metal.name == "COPPER") {
          return 'o';
        }
        return 'O';
      }
      return 'i';
    }

    char getCubeChar(Cube cube) {
      if (cube.wall.name == "AIR") {
        foreground = getMaterialForegroundColor(cube.floor);
        if (cube.floor.name == "GRASS") {
          return ',';
        } else if (cube.floor.name == "WOOD") {
          return '_';
        }
        return getChar(cube.floor.name);
      }

      if (cube.wall.name == "WOOD") {
        return '+';
      }
      foreground = getMaterialForegroundColor(cube.wall);
      return getChar(cube.wall.name);
    }

    static char getChar(string str) {
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

    import terminal.Settings;
    const static auto GRASS_COLOR = enable16colors ? TerminalColor.LIGHT_GREEN : TerminalColor.GREEN;
    const static auto STONE_COLOR = enable16colors ? TerminalColor.GRAY : TerminalColor.BLACK;
    const static auto WATER_COLOR = enable16colors ? TerminalColor.LIGHT_CYAN : TerminalColor.CYAN;
    const static auto SAND_COLOR = enable16colors ? TerminalColor.LIGHT_YELLOW : TerminalColor.YELLOW;
    const static auto GOLD_COLOR = enable16colors ? TerminalColor.LIGHT_YELLOW : TerminalColor.YELLOW;
    const static auto SILVER_COLOR = enable16colors ? TerminalColor.BRIGHT_WHITE : TerminalColor.WHITE;
    const static auto IRON_COLOR = enable16colors ? TerminalColor.BRIGHT_WHITE : TerminalColor.WHITE;
    const static auto COPPER_COLOR = enable16colors ? TerminalColor.LIGHT_RED : TerminalColor.RED;
    static TerminalColor getMaterialForegroundColor(Material material) {
      if (material.name == "GRASS") {
        return GRASS_COLOR;
      }
      if (material.name == "WOOD") {
        return TerminalColor.YELLOW;
      }
      if (material.name == "STONE") {
        return STONE_COLOR;
      }
      if (material.name == "WATER") {
        return WATER_COLOR;
      }
      if (material.name == "SAND") {
        return SAND_COLOR;
      }
      if (material.name == "GOLD") {
        return GOLD_COLOR;
      }
      if (material.name == "SILVER") {
        return SILVER_COLOR;
      }
      if (material.name == "IRON") {
        return IRON_COLOR;
      }
      if (material.name == "COPPER") {
        return COPPER_COLOR;
      }
      if (material.name == "VOID") {
        return TerminalColor.BLACK;
      }
      if (material.name == "SILT") {
        return TerminalColor.GREEN;
      }
      if (material.name == "TIN") {
        return TerminalColor.BLUE;
      }
      if (material.name == "SOIL") {
        return TerminalColor.YELLOW;
      }
      return TerminalColor.MAGENTA;
  }
}

/* companion object {
fun getMaterialForegroundColor(material: Material): RgbColor {
when (material) {
Material.GRASS -> {
return RgbColor(0, 255, 0)
}
Material.WOOD -> {
return RgbColor(255, 255, 0)
}
Material.STONE -> {
return RgbColor(64, 64, 64)
}
Material.WATER -> {
return RgbColor(0, 95, 175)
}
Material.SAND -> {
return RgbColor(255, 255, 0)
}
Material.GOLD -> {
return RgbColor(255, 255, 0)
}
Material.SILVER -> {
return RgbColor(200, 200, 200)
}
Material.IRON -> {
return RgbColor(255, 255, 255)
}
Material.COPPER -> {
return RgbColor(184, 115, 51)
}
Material.VOID -> {
return RgbColor(0, 0, 0)
}
Material.SILT -> {
return RgbColor(0, 100, 0)
}
Material.TIN -> {
return RgbColor(145, 145, 145)
}
Material.SOIL -> {
return RgbColor(184, 115, 51)
}
else -> return RgbColor(255, 255, 255)
}
}
} */
