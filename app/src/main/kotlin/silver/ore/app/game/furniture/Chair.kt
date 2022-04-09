package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Chair : Furniture() {
    override fun display(): Char {
        return 'c'
    }
}
