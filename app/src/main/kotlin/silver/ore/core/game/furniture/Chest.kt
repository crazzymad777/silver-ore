package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Chest : Furniture() {
    override fun display(): Char {
        return 'G'
    }

    override fun getName(): String {
        return "Chest"
    }
}
