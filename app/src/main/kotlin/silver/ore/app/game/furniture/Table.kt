package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Table : Furniture() {
    override fun display(): Char {
        return 'T'
    }
}
