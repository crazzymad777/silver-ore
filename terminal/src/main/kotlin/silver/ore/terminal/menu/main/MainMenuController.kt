package silver.ore.terminal.menu.main

import silver.ore.terminal.Component
import silver.ore.terminal.MenuComponent
import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.Controller
import silver.ore.terminal.menu.test.TestMenuController

class MainMenuController(val display: AbstractDisplay) : Controller() {
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

        if (data.selectedEntry == data.entries[MainMenuData.ENTRIES.TEST.i]) {
            val component = Component(display, MenuComponent(display, TestMenuController(display)))
            component.run()
            display.clear()
            update = true
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
