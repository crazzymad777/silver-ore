package silver.ore.terminal

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key

// Component(JLineDisplay(), MainMenu()).run()
// Component:
// 1) check display sizes
// 2) draw itself (if updated)
// 3) draw child components (if updated)
// 4) handle key

abstract class AbstractComponent(private val display: AbstractDisplay) {
    fun run() {
        var width: Int = display.getWidth()
        var height: Int = display.getHeight()
        do {
            if (display.getWidth() != width || display.getHeight() != height) {
                width = display.getWidth()
                height = display.getHeight()
                resize(width, height)
            }

            process()
            if (update()) {
                draw()
            }

            recvKey(display.read())
        } while(!closed())
    }

    abstract fun closed(): Boolean
    abstract fun process()
    abstract fun recvKey(key: Key)
    abstract fun resize(width: Int, height: Int)
    abstract fun update(): Boolean
    abstract fun draw()
}
