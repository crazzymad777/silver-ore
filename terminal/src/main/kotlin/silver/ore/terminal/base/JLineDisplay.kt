package silver.ore.terminal.base

import org.jline.terminal.Terminal
import org.jline.utils.AttributedString
import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle
import org.jline.utils.Display

class JLineDisplay(val resizeCallback: (Int, Int) -> Unit) : AbstractDisplay() {
    val terminal: JLineTerminal = JLineTerminal()
    private val keyboard = JLineKeyboard(terminal.terminal, terminal.reader)
    private val display = Display(terminal.terminal, true)
    private val matrix = DisplayMatrix(terminal.terminal.width, terminal.terminal.height)
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
        matrix.resize(width, height)
    }

    override fun getWidth(): Int {
        return terminal.terminal.width
    }

    override fun getHeight(): Int {
        return terminal.terminal.height
    }

    override fun put(x: Int, y: Int, glyph: Glyph) {
        matrix.put(x, y, glyph)
    }

    override fun put(x: Int, y: Int, glyphs: Array<Glyph>) {
        matrix.put(x, y, glyphs)
    }

    override fun put(x: Int, y: Int, glyphs: List<Glyph>) {
        matrix.put(x, y, glyphs)
    }

    fun put(x: Int, y: Int, string: String) {
        matrix.put(x, y, string)
    }

    override fun read(): Key {
        return keyboard.fetch()
    }

    override fun reset() {
        display.reset()
    }

    override fun clear() {
        matrix.clear()
    }

    override fun update() {
        if (!matrix.suspendMatrix) {
            val attributedStringBuilder = AttributedStringBuilder((terminal.terminal.width+1)*terminal.terminal.height)

            var oldForegroundColor = RgbColor(255, 255, 255)
            var oldBackgroundColor = RgbColor(0, 0, 0)
            for (row in matrix.matrix) {
                for (glyph in row) {
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
            }
            display.update(listOf(attributedStringBuilder.toAttributedString()), -1)
        }
    }
}
