package silver.ore.terminal.menu.main

import silver.ore.terminal.menu.MenuEntry

class MainMenuData {
    enum class ENTRIES(val i: Int) {
        CREATE_WORLD(0),
        SELECT_WORLD(1),
        SOURCE_CODE(2),
        SETTINGS(3),
        QUIT(4)
    }

    val entries = arrayListOf(MenuEntry("Create a new world"),
                              MenuEntry("Select world"),
                              MenuEntry("Source code"),
                              MenuEntry("Settings"),
                              MenuEntry("Quit"))
    private var index = 0
    var selectedEntry: MenuEntry = entries[index]
    fun down() {
        index++
        if (entries.size == index) {
            index = 0
        }
        selectedEntry = entries[index]
    }

    fun up() {
        index--
        if (-1 == index) {
            index = entries.size - 1
        }
        selectedEntry = entries[index]
    }
}
