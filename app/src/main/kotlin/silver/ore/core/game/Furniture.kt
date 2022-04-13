package silver.ore.core.game

abstract class Furniture : Item() {
    abstract override fun display(): Char
    override fun getName(): String {
        return "Furniture"
    }
}
