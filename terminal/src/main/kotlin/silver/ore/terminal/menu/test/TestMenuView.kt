package silver.ore.terminal.menu.test

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Glyph

class TestMenuView(val display: AbstractDisplay, private val data: TestMenuData) {
    fun draw() {
        display.clear()
        var i = 0
        for (entry in data.map) {
            val str = "${entry.key}: ${entry.value}"
            display.put(0, i, Glyph.fromString(str, entry.value))
            i++
        }
    }
}
