package silver.ore.terminal

abstract class AbstractTerminal {
    abstract fun builder(): AbstractTextBuilder
    abstract fun getType(): String
    abstract fun clear()
}
