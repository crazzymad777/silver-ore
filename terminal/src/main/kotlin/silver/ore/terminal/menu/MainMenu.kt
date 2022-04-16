package silver.ore.terminal.menu

import silver.ore.terminal.base.AbstractDisplay

class MainMenu(display: AbstractDisplay) : Menu(display) {
    var entry: Int = 0
    var lastEntry: Int = 0

    private fun draw() {
        push(MenuEntry("Create a new world"))
        push(MenuEntry("Select world"))
        push(MenuEntry("Source code"))
        push(MenuEntry("Settings"))
        push(MenuEntry("Quit"))
        selectedEntry = entries[0]
        drawMenuEntries()
    }

    init {
        draw()
        update = true
    }

    override fun process() {
        if (lastEntry != entry) {
            val id = entry.toUInt()%entries.size.toUInt()
            selectedEntry = entries[id.toInt()]
            drawMenuEntries()
            lastEntry = entry
            update = true
        }
    }

    override fun recvKey(key: Int) {
        if (key.toChar() == 'q' || key < 0) {
            closed = true
        }

        if (key.toChar() == 'w') {
            entry--
        }

        if (key.toChar() == 's') {
            entry++
        }
    }
}
