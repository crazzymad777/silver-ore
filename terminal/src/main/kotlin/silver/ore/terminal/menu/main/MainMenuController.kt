package silver.ore.terminal.menu.main

import silver.ore.terminal.AbstractComponent
import silver.ore.terminal.MenuComponent
import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.Controller
import silver.ore.terminal.menu.test.TestMenuController

class MainMenuController(val display: AbstractDisplay) : Controller() {
    private val data = MainMenuData()
    private val view = MainMenuView(display, data)
    private var child: AbstractComponent? = null
    override fun draw() {
        val child = this.child

        if (child != null) {
            child.draw()
        } else {
            view.draw()
        }
    }

    override fun process() {
        if (child?.closed() == true) {
            child = null
            display.clear()
            update = true
        }

        child?.process()
    }

    private fun enter() {
        if (data.selectedEntry == data.entries[MainMenuData.ENTRIES.QUIT.i]) {
            closed = true
        }

        if (data.selectedEntry == data.entries[MainMenuData.ENTRIES.TEST.i]) {
            child = MenuComponent(display, TestMenuController(display))
            display.clear()
            update = true
        }
    }

    override fun recvKey(key: Key) {
        val child = this.child

        if (child != null) {
            child.recvKey(key)
        } else {
            if (key.normalize() == 'q' || key.keycode < 0) {
                closed = true
            }

            if (key.normalize() == 'w' || key.binding == Key.BINDING.UP) {
                data.up()
                update = true
            }

            if (key.normalize() == 's' || key.binding == Key.BINDING.DOWN) {
                data.down()
                update = true
            }

            if (key.keycode == 10 || key.binding == Key.BINDING.ENTER) {
                enter()
            }
        }
    }
}
