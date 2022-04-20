package silver.ore.terminal

import silver.ore.terminal.base.JLineDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.main.MainMenuController

// Component(JLineDisplay(), MainMenu()).run()
// Component:
// 1) check display sizes
// 2) draw itself (if updated)
// 3) draw child components (if updated)
// 4) handle key

open class RootComponent : AbstractComponent() {
    private val component: AbstractComponent
    val display = JLineDisplay { x: Int, y: Int -> resize(x, y) }
    init {
        component = MenuComponent(display, MainMenuController(display))
    }

    override fun read(): Key {
        return display.read()
    }

    override fun closed(): Boolean {
        return component.closed()
    }

    override fun process() {
        component.process()
    }

    override fun recvKey(key: Key) {
        component.recvKey(key)
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
