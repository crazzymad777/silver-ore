package silver.ore.terminal.menu

import silver.ore.terminal.base.Glyph
import silver.ore.terminal.base.RgbColor

class MenuEntry(title: String) {
    val glyphs = Glyph.fromString(title)
    val selectedGlyphs = Glyph.fromString(title, RgbColor(255, 0, 0))
}
