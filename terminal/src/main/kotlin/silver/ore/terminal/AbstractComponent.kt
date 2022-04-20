package silver.ore.terminal

import silver.ore.terminal.base.Key

// Component(JLineDisplay(), MainMenu()).run()
// Component:
// 1) check display sizes
// 2) draw itself (if updated)
// 3) draw child components (if updated)
// 4) handle key

abstract class AbstractComponent {
    fun run() {
        do {
            process()
            if (update()) {
                draw()
            }
            recvKey(read())
        } while(!closed())
    }
    abstract fun read(): Key
    abstract fun closed(): Boolean
    abstract fun process()
    abstract fun recvKey(key: Key)
    abstract fun resize(width: Int, height: Int)
    abstract fun update(): Boolean
    abstract fun draw()
}
