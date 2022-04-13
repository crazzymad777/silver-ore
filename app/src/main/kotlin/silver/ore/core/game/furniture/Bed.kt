package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Bed : Furniture() {
    override fun display(): Char {
        return 'B'
    }

    override fun getName(): String {
        return "Bed"
    }
}
