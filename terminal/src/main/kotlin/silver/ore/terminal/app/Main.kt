package silver.ore.terminal.app

import silver.ore.terminal.base.JLineDisplay
import silver.ore.terminal.base.Key
import silver.ore.terminal.menu.MainMenu

fun main() {
    val display = JLineDisplay()
    val mainMenu = MainMenu(display)

    var key = Key()
    var y = 0
    do {
        display.put(0, y, silver.ore.terminal.base.Glyph.fromString(key.toString()))
        display.reset()
        display.update()
        mainMenu.process()
        if (mainMenu.update) {
            display.reset()
            display.update()
            mainMenu.update = false
        }
        key = display.read()
        mainMenu.recvKey(key)
        y++
        if (y >= display.getHeight()) {
            y = 0;
        }
    } while(!mainMenu.closed)
}
