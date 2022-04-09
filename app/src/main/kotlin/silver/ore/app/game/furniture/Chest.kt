package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Chest : Furniture() {
    override fun display(): Char {
        return 'G'
    }
}
