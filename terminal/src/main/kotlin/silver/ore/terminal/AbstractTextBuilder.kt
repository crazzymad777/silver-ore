package silver.ore.terminal

abstract class AbstractTextBuilder {
    abstract fun setForeground(rgb: AbstractColor): AbstractTextBuilder
    abstract fun setBackground(rgb: AbstractColor): AbstractTextBuilder
    abstract fun append(char: Char): AbstractTextBuilder
    abstract fun append(str: String): AbstractTextBuilder
    abstract fun toAnsi(): String
    abstract fun clear()
}
