package silver.ore.terminal.menu.test

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.Controller

class TestMenuController(display: AbstractDisplay) : Controller() {
    private val data = TestMenuData()
    private val view = TestMenuView(display, data)
    override fun draw() {
        view.draw()
    }

    override fun process() {
    }

    override fun recvKey(key: Key) {
        if (key.toChar() == 'q' || key.keycode < 0) {
            closed = true
        }
    }
}
