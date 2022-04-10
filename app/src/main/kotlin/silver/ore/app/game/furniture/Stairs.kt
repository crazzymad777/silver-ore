package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Stairs : Furniture() {
    override fun display(): Char {
        return 'X'
    }

    override fun getName(): String {
        return "Stairs"
    }
}
