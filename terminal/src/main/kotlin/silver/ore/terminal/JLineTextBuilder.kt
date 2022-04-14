package silver.ore.terminal

import org.jline.terminal.Terminal
import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle

class JLineTextBuilder(val terminal: Terminal) : AbstractTextBuilder() {
    private var builder = AttributedStringBuilder()

    override fun setForeground(rgb: RgbColor): AbstractTextBuilder {
        builder.style(AttributedStyle.DEFAULT.foreground(rgb.r, rgb.g, rgb.b))
        return this
    }

    override fun setBackground(rgb: RgbColor): AbstractTextBuilder {
        builder.style(AttributedStyle.DEFAULT.background(rgb.r, rgb.g, rgb.b))
        return this
    }

    override fun append(char: Char): AbstractTextBuilder {
        builder.append(char)
        return this
    }

    override fun append(str: String): AbstractTextBuilder {
        builder.append(str)
        return this
    }

    override fun toAnsi(): String {
        return builder.toAnsi(terminal)
    }

    override fun clear() {
        builder = AttributedStringBuilder()
    }
}
