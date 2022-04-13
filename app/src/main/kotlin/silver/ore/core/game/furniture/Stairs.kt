package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Stairs : Furniture() {
    override fun display(): Char {
        return 'X'
    }

    override fun getName(): String {
        return "Stairs"
    }
}
