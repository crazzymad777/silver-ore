package silver.ore.terminal

import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle

class JLineTextBuilder : AbstractTextBuilder() {
    private var builder = AttributedStringBuilder()

    override fun setForeground(rgb: AbstractColor): AbstractTextBuilder {
        val color = JLineColor.obtainColor(rgb).getIntColor()
        builder.style(AttributedStyle.DEFAULT.foreground(color))
        return this
    }

    override fun setBackground(rgb: AbstractColor): AbstractTextBuilder {
        val color = JLineColor.obtainColor(rgb).getIntColor()
        builder.style(AttributedStyle.DEFAULT.background(color))
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
        return builder.toAnsi()
    }

    override fun clear() {
        builder = AttributedStringBuilder()
    }
}
