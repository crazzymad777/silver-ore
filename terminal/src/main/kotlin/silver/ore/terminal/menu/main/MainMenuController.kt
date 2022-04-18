package silver.ore.terminal.menu.main

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.Controller

class MainMenuController(display: AbstractDisplay) : Controller() {
    private val data = MainMenuData()
    private val view = MainMenuView(display, data)
    override fun draw() {
        view.draw()
    }

    override fun process() {
    }

    private fun enter() {
        if (data.selectedEntry == data.entries[MainMenuData.ENTRIES.QUIT.i]) {
            closed = true
        }
    }

    override fun recvKey(key: Key) {
        if (key.toChar() == 'q' || key.keycode < 0) {
            closed = true
        }

        if (key.toChar() == 'w' || key.binding == Key.BINDING.UP) {
            data.up()
            update = true
        }

        if (key.toChar() == 's' || key.binding == Key.BINDING.DOWN) {
            data.down()
            update = true
        }

        if (key.keycode == 10 || key.binding == Key.BINDING.ENTER) {
            enter()
        }
    }
}
