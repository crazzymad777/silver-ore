package silver.ore.terminal.app

import silver.ore.terminal.Component
import silver.ore.terminal.MenuComponent
import silver.ore.terminal.base.JLineDisplay
import silver.ore.terminal.menu.main.MainMenuController

fun main() {
    val display = JLineDisplay()
    val component = Component(display, MenuComponent(display, MainMenuController(display)))
    component.run()
}
