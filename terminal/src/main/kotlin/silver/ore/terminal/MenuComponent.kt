package silver.ore.terminal

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.Menu

// Component(JLineDisplay(), MainMenu()).run()
// Component:
// 1) check display sizes
// 2) draw itself (if updated)
// 3) draw child components (if updated)
// 4) handle key

open class MenuComponent(private val display: AbstractDisplay, private val menu: Menu): AbstractComponent(display) {
    override fun closed(): Boolean {
        return menu.closed
    }

    override fun process() {
        menu.process()
    }

    override fun recvKey(key: Key) {
        menu.recvKey(key)
    }

    override fun resize(width: Int, height: Int) {
        display.resize(width, height)
        menu.resize()
    }

    override fun update(): Boolean {
        return menu.update
    }

    override fun draw() {
        display.reset()
        display.update()
        menu.update = false // method call?
    }
}
