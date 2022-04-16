package silver.ore.terminal.menu

import silver.ore.terminal.base.AbstractDisplay
import silver.ore.terminal.base.Glyph

class TextMenu(display: AbstractDisplay, private val text: String) : Menu(display) {
    override fun draw() {
        display.clear()
        display.put(display.getWidth()/2-text.length/2,
            display.getHeight()/2,
               Glyph.fromString(text)
        )
    }

    override fun process() {
    }

    override fun recvKey(key: Int) {
        if (key.toChar() == 'b') {
            closed = true
        }
    }

    override val action = ACTION.ENTER
}