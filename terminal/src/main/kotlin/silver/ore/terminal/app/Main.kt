package silver.ore.terminal.app

import silver.ore.terminal.MenuComponent
import silver.ore.terminal.base.JLineDisplay
import silver.ore.terminal.menu.MainMenu

fun main() {
    val display = JLineDisplay()
    val component = MenuComponent(display, MainMenu(display))
    component.run()
}
