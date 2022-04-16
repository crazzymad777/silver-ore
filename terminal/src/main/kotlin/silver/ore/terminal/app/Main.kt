package silver.ore.terminal.app

import silver.ore.terminal.base.JLineDisplay
import silver.ore.terminal.menu.MainMenu

fun main() {
    val display = JLineDisplay()
    val mainMenu = MainMenu(display)

    do {
        mainMenu.process()
        if (mainMenu.update) {
            display.reset()
            display.update()
            mainMenu.update = false
        }
        mainMenu.recvKey(display.read())
    } while(!mainMenu.closed)
}
