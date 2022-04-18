package silver.ore.terminal.menu

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Key

class QuitEntry(display: AbstractDisplay) : Menu(display) {
    override fun draw() {

    }

    override fun process() {

    }

    override fun recvKey(key: Key) {

    }

    override val action: ACTION = ACTION.QUIT
}
