package silver.ore.core.game.furniture

import silver.ore.core.game.Furniture

class Door : Furniture() {
    override fun display(): Char {
        return 'D'
    }

    override fun getName(): String {
        return "Door"
    }
}
