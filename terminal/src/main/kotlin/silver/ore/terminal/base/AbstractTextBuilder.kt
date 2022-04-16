package silver.ore.terminal.base

abstract class AbstractTextBuilder {
    abstract fun setForeground(rgb: RgbColor): AbstractTextBuilder
    abstract fun setBackground(rgb: RgbColor): AbstractTextBuilder
    abstract fun append(char: Char): AbstractTextBuilder
    abstract fun append(str: String): AbstractTextBuilder
    abstract fun toAnsi(): String
    abstract fun clear()
}
