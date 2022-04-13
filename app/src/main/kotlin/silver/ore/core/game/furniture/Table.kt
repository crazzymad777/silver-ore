package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Table : Furniture() {
    override fun display(): Char {
        return 'T'
    }

    override fun getName(): String {
        return "Table"
    }
}
