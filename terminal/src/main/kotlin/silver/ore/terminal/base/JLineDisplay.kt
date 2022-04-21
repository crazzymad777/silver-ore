package silver.ore.terminal.base

import org.jline.terminal.Terminal
import org.jline.utils.AttributedString
import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle
import org.jline.utils.Display

class JLineDisplay(val resizeCallback: (Int, Int) -> Unit) : AbstractDisplay() {
    val terminal: JLineTerminal = JLineTerminal()
    private var suspendMatrix: Boolean = false
    private val keyboard = JLineKeyboard(terminal.terminal, terminal.reader)
    private val display = Display(terminal.terminal, true)
    init {
        display.resize(terminal.terminal.height, terminal.terminal.width)
        terminal.terminal.handle(Terminal.Signal.WINCH, this::handle)
    }

    fun handle(signal: Terminal.Signal) {
        if (signal == Terminal.Signal.WINCH) {
            display.resize(terminal.terminal.height, terminal.terminal.width)
            resize(width = terminal.terminal.width, height = terminal.terminal.height)
            resizeCallback(terminal.terminal.width, terminal.terminal.height)
            reset()
            update()
        }
    }

    override fun resize(width: Int, height: Int) {
        suspendMatrix = true
        matrix = ArrayList(terminal.terminal.height)
        for(y in 0 until height) {
            val row = ArrayList<Glyph>(terminal.terminal.width)
            for(x in 0 until width) {
                row.add(Glyph())
            }
            matrix.add(row)
        }
        suspendMatrix = false
    }

    override fun getWidth(): Int {
        return terminal.terminal.width
    }

    override fun getHeight(): Int {
        return terminal.terminal.height
    }

    private var matrix = ArrayList<ArrayList<Glyph>>(terminal.terminal.height)
    init {
        for(y in 0 until terminal.terminal.height) {
            val row = ArrayList<Glyph>(terminal.terminal.width)
            for(x in 0 until terminal.terminal.width) {
                row.add(Glyph())
            }
            matrix.add(row)
        }
    }

    override fun put(x: Int, y: Int, glyph: Glyph) {
        if (!suspendMatrix) {
            if (y >= 0 && y < terminal.terminal.height) {
                if (x >= 0 && x < terminal.terminal.width) {
                    matrix[y][x] = glyph
                }
            }
        }
    }

    override fun put(x: Int, y: Int, glyphs: Array<Glyph>) {
        if (!suspendMatrix) {
            for (i in x until glyphs.size + x) {
//                matrix[y][i] = glyphs[i - x]
                put(i, y, glyphs[i - x])
            }
        }
    }

    fun put(x: Int, y: Int, string: String) {
        if (!suspendMatrix) {
            for (i in x until string.length + x) {
//                matrix[y][i] = Glyph(char = string[i - x])
                put(i, y, Glyph(char = string[i - x]))
            }
        }
    }

    override fun read(): Key {
        return keyboard.fetch()
    }

    override fun reset() {
//        put(0, 0, "${terminal.terminal.width}:${terminal.terminal.height}")
        display.reset()
    }

    override fun clear() {
        if (!suspendMatrix) {
            for (x in 0 until getWidth()) {
                for (y in 0 until getHeight()) {
                    matrix[y][x] = Glyph()
                }
            }
        }
    }

    override fun update() {
        if (!suspendMatrix) {
            val list = ArrayList<AttributedString>(matrix.size)
            val attributedStringBuilder = AttributedStringBuilder(terminal.terminal.width)

            var row: ArrayList<Glyph>
            for (i in 0 until matrix.size) {
                row = matrix[i]
                var oldForegroundColor = RgbColor(255, 255, 255)
                var oldBackgroundColor = RgbColor(0, 0, 0)

                var glyph: Glyph
                for (j in 0 until row.size) {
                    glyph = row[j]
                    val foregroundColor = glyph.foreground
                    val backgroundColor = glyph.background
                    if (oldForegroundColor != foregroundColor) {
                        attributedStringBuilder.style(
                            AttributedStyle.DEFAULT.foreground(
                                foregroundColor.r,
                                foregroundColor.g,
                                foregroundColor.b
                            )
                        )
                        oldForegroundColor = foregroundColor
                    }
                    if (oldBackgroundColor != backgroundColor) {
                        attributedStringBuilder.style(
                            AttributedStyle.DEFAULT.background(
                                backgroundColor.r,
                                backgroundColor.g,
                                backgroundColor.b
                            )
                        )
                        oldBackgroundColor = backgroundColor
                    }
                    attributedStringBuilder.append(glyph.char)
                }
                list.add(attributedStringBuilder.toAttributedString())
                attributedStringBuilder.setLength(0)
            }
            display.update(list, -1)
        }
    }
}
