package silver.ore.terminal.menu

import silver.ore.terminal.base.AbstractDisplay

abstract class Menu(protected val display: AbstractDisplay) {
    protected val entries = ArrayList<MenuEntry>()
    var selectedEntry: MenuEntry? = null
    fun drawMenuEntries() {
        val length = entries.size
        for ((i, entry) in entries.withIndex()) {
            val glyphs = if (selectedEntry == entry) {
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

    fun push(entry: MenuEntry) {
        entries.add(entry)
    }

    abstract fun process()
    abstract fun recvKey(key: Int)
    var closed: Boolean = false
    var update: Boolean = false
}
