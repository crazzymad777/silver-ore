package silver.ore.core.game

open class Mob: Item() {
    override fun getName(): String {
        return "Mob"
    }

    override fun display(): Char {
        return 'm'
    }
}
