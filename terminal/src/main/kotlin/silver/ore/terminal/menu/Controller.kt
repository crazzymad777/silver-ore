package silver.ore.terminal.menu

import silver.ore.terminal.base.Key

abstract class Controller {
    var closed: Boolean = false
    var update: Boolean = true
    abstract fun draw()
    abstract fun process()
    abstract fun recvKey(key: Key)
    open fun resize() {
        draw()
    }
}
