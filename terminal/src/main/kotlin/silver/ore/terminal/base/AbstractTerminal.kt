package silver.ore.terminal.base

abstract class AbstractTerminal {
    abstract fun builder(): AbstractTextBuilder
    abstract fun getType(): String
    abstract fun clear()
}
