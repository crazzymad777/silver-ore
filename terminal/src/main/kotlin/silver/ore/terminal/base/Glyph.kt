package silver.ore.terminal.base

data class Glyph(val foreground: RgbColor = RgbColor(255, 255, 255),
                 val background: RgbColor = RgbColor(0, 0, 0),
                 val char: Char = ' ') {
    companion object {
        fun fromString(str: String, foreground: RgbColor = RgbColor(255, 255, 255), background: RgbColor = RgbColor(0, 0, 0)): Array<Glyph> {
            return Array(str.length) {
                Glyph(foreground, background, str[it])
            }
        }

    }
}
