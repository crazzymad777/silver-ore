package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Bed : Furniture() {
    override fun display(): Char {
        return 'B'
    }

    override fun getName(): String {
        return "Bed"
    }
}
