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
        matrix = Array(terminal.terminal.height) {
            Array(terminal.terminal.width) {
                Glyph()
            }
        }
        suspendMatrix = false
    }

    override fun getWidth(): Int {
        return terminal.terminal.width
    }

    override fun getHeight(): Int {
        return terminal.terminal.height
    }

    private var matrix = Array(terminal.terminal.height) {
        Array(terminal.terminal.width) {
            Glyph()
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
            val row = matrix[y]
            for (i in x until glyphs.size + x) {
                row[i] = glyphs[i - x]
//                put(i, y, glyphs[i - x])
            }
        }
    }

    override fun put(x: Int, y: Int, glyphs: List<Glyph>) {
        if (!suspendMatrix) {
            val row = matrix[y]
            for (i in x until glyphs.size + x) {
                row[i] = glyphs[i - x]
//                put(i, y, glyphs[i - x])
            }
        }
    }

    fun put(x: Int, y: Int, string: String) {
        if (!suspendMatrix) {
            for (i in x until string.length + x) {
                matrix[y][i] = Glyph(char = string[i - x])
//                put(i, y, Glyph(char = string[i - x]))
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
            val attributedStringBuilder = AttributedStringBuilder(terminal.terminal.width*terminal.terminal.height)

            var oldForegroundColor = RgbColor(255, 255, 255)
            var oldBackgroundColor = RgbColor(0, 0, 0)
            for (row in matrix) {
                var glyph: Glyph
                for (element in row) {
                    glyph = element
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
                attributedStringBuilder.append(AttributedString.NEWLINE)
//                attributedStringBuilder.setLength(0)
            }
            display.update(listOf(attributedStringBuilder.toAttributedString()), -1)
        }
    }
}
