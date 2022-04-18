package silver.ore.terminal

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key

// Component(JLineDisplay(), MainMenu()).run()
// Component:
// 1) check display sizes
// 2) draw itself (if updated)
// 3) draw child components (if updated)
// 4) handle key

open class Component(display: AbstractDisplay, private val component: AbstractComponent) : AbstractComponent(display) {
    override fun closed(): Boolean {
        return component.closed()
    }

    override fun process() {
        component.process()
    }

    override fun recvKey(key: Key) {
        recvKey(key)
    }

    override fun resize(width: Int, height: Int) {
        component.resize(width, height)
    }

    override fun update(): Boolean {
        return component.update()
    }

    override fun draw() {
        component.draw()
    }
}
