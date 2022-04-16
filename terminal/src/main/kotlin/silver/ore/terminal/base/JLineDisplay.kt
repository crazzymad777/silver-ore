package silver.ore.terminal.base

import org.jline.utils.AttributedString
import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle
import org.jline.utils.Display

class JLineDisplay : AbstractDisplay() {
    val terminal: JLineTerminal = JLineTerminal()
    private val display = Display(terminal.terminal, true)
    init {
        display.resize(terminal.terminal.height, terminal.terminal.width)
    }

    override fun getWidth(): Int {
        return terminal.terminal.width
    }

    override fun getHeight(): Int {
        return terminal.terminal.height
    }

    private val matrix = ArrayList<ArrayList<Glyph>>()
    init {
        for(y in 0 until terminal.terminal.height) {
            val row = ArrayList<Glyph>()
            for(x in 0 until terminal.terminal.width) {
                row.add(Glyph())
            }
            matrix.add(row)
        }
    }

    override fun put(x: Int, y: Int, glyph: silver.ore.terminal.base.Glyph) {
        matrix[y][x] = glyph
    }

    override fun put(x: Int, y: Int, glyphs: Array<silver.ore.terminal.base.Glyph>) {
        for (i in x until glyphs.size+x) {
            matrix[y][i] = glyphs[i-x]
        }
    }

    override fun read(): Int {
        return terminal.reader.read()
    }

    override fun reset() {
        display.reset()
    }

    override fun clear() {
        for (x in 0 until getWidth()) {
            for (y in 0 until getHeight()) {
                matrix[y][x] = Glyph()
            }
        }
    }

    override fun update() {
        val list = ArrayList<AttributedString>()
        for (row in matrix) {
            val attributedStringBuilder = AttributedStringBuilder()
            var oldForegroundColor = RgbColor(255, 255, 255)
            var oldBackgroundColor = RgbColor(0, 0, 0)
            for (glyph in row) {
                val foregroundColor = glyph.foreground
                val backgroundColor = glyph.background
                if (oldForegroundColor != foregroundColor) {
                    attributedStringBuilder.style(AttributedStyle.DEFAULT.foreground(foregroundColor.r, foregroundColor.g, foregroundColor.b))
                    oldForegroundColor = foregroundColor
                }
                if (oldBackgroundColor != backgroundColor) {
                    attributedStringBuilder.style(AttributedStyle.DEFAULT.background(backgroundColor.r, backgroundColor.g, backgroundColor.b))
                    oldBackgroundColor = backgroundColor
                }
//                println(glyph.char)
                attributedStringBuilder.append(glyph.char)
            }
            list.add(attributedStringBuilder.toAttributedString())
        }
        display.update(list,0)
    }
}
