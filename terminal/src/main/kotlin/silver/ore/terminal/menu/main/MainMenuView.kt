package silver.ore.terminal.menu.main

import silver.ore.terminal.base.AbstractDisplay

class MainMenuView(val display: AbstractDisplay, private val data: MainMenuData) {
    fun draw() {
        val length = data.entries.size
        for ((i, entry) in data.entries.withIndex()) {
            val glyphs = if (data.selectedEntry == entry) {
                entry.selectedGlyphs
            } else {
                entry.glyphs
            }

            val stringLength = glyphs.size
            display.put(display.getWidth()/2-stringLength/2,
                display.getHeight()/2 + i - length/2 - 5,
                glyphs)
        }
    }
}
