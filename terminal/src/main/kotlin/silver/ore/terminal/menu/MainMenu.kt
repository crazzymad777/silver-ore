package silver.ore.terminal.menu

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key

class MainMenu(display: AbstractDisplay) : Menu(display) {
    override val action: ACTION
        get() = ACTION.ENTER
    var entry: Int = 0
    var lastEntry: Int = 0

    init {
        push(MenuEntry("Create a new world"))
        push(MenuEntry("Select world"))
        push(MenuEntry("Source code", TextMenu(display,"Source code: https://gitlab.com/freedom-pride-chat/silver-ore")))
        push(MenuEntry("Settings"))
        push(MenuEntry("Quit", QuitEntry(display)))
        selectedEntry = entries[0]
    }

    override fun draw() {
        drawMenuEntries()
    }

    init {
        draw()
        update = true
    }

    override fun process() {
        if (menuEntry != null) {
            val menu = menuEntry!!.menu
            if (menu != null) {
                update = menu.update

                if (menu.closed) {
                    menuEntry = null
                    display.clear()
                    draw()
                    update = true
                }
            }
        }
        if (lastEntry != entry) {
            lastEntry = entry
            update = true
        }
    }

    private fun entryChanged() {
        val id = entry.toUInt()%entries.size.toUInt()
        selectedEntry = entries[id.toInt()]
        drawMenuEntries()
    }

    private var menuEntry: MenuEntry? = null
    private fun enter() {
        menuEntry = selectedEntry
        menuEntry!!.menu?.draw()
        update = true
        if (menuEntry!!.menu?.action == ACTION.QUIT) {
            closed = true
        }
    }

    override fun recvKey(key: Key) {
        if (menuEntry != null) {
            menuEntry!!.menu?.recvKey(key)
        }

        if (key.toChar() == 'q' || key.keycode < 0) {
            closed = true
        }

        if (key.toChar() == 'w' || key.binding == Key.BINDING.UP) {
            entry--
            entryChanged()
        }

        if (key.toChar() == 's' || key.binding == Key.BINDING.DOWN) {
            entry++
            entryChanged()
        }

        if (key.keycode == 10 || key.binding == Key.BINDING.ENTER) {
            enter()
        }
    }
}
