package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Chair : Furniture() {
    override fun display(): Char {
        return 'c'
    }

    override fun getName(): String {
        return "Chair"
    }
}
