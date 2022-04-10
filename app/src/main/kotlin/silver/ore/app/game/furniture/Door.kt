package silver.ore.app.game.furniture

import silver.ore.app.game.Furniture

class Door : Furniture() {
    override fun display(): Char {
        return 'D'
    }

    override fun getName(): String {
        return "Door"
    }
}
