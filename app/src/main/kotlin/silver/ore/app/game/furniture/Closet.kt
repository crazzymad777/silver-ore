package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Closet : Furniture() {
    override fun display(): Char {
        return 'H'
    }
}