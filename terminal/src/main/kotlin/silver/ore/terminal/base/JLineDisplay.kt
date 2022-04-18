package silver.ore.terminal.base

import org.jline.utils.AttributedString
import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle
import org.jline.utils.Display

class JLineDisplay : AbstractDisplay() {
    val terminal: JLineTerminal = JLineTerminal()
    private val keyboard = JLineKeyboard(terminal.terminal, terminal.reader)
    private val display = Display(terminal.terminal, true)
    init {
        display.resize(terminal.terminal.height, terminal.terminal.width)
    }

    override fun resize(width: Int, height: Int) {
        matrix = ArrayList()
        for(y in 0 until height) {
            val row = ArrayList<Glyph>()
            for(x in 0 until width) {
                row.add(Glyph())
            }
            matrix.add(row)
        }
    }

    override fun getWidth(): Int {
        return terminal.terminal.width
    }

    override fun getHeight(): Int {
        return terminal.terminal.height
    }

    private var matrix = ArrayList<ArrayList<Glyph>>()
    init {
        for(y in 0 until terminal.terminal.height) {
            val row = ArrayList<Glyph>()
            for(x in 0 until terminal.terminal.width) {
                row.add(Glyph())
            }
            matrix.add(row)
        }
    }

    override fun put(x: Int, y: Int, glyph: Glyph) {
        matrix[y][x] = glyph
    }

    override fun put(x: Int, y: Int, glyphs: Array<Glyph>) {
        for (i in x until glyphs.size+x) {
            matrix[y][i] = glyphs[i-x]
        }
    }

    override fun read(): Key {
        return keyboard.fetch()
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
        display.update(list,-1)
    }
}
