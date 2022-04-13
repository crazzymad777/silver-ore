package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Closet : Furniture() {
    override fun display(): Char {
        return 'H'
    }

    override fun getName(): String {
        return "Closet"
    }
}