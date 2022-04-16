package silver.ore.terminal.menu

import silver.ore.terminal.base.AbstractDisplay

class QuitEntry(display: AbstractDisplay) : Menu(display) {
    override fun draw() {
        TODO("Not yet implemented")
    }

    override fun process() {
        TODO("Not yet implemented")
    }

    override fun recvKey(key: Int) {
        TODO("Not yet implemented")
    }

    override val action: ACTION = ACTION.QUIT
}
