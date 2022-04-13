package silver.ore.core.game

abstract class Item {
    open fun getName(): String {
        return "Item"
    }

    abstract fun display(): Char
}
