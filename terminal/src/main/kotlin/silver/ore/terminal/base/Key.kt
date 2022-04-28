package silver.ore.terminal.base

import silver.ore.terminal.utils.KeyboardLayout

data class Key(val binding: BINDING = BINDING.NO_MATCH, val keycode: Int = 0) {
    companion object {
        val pc105ru = KeyboardLayout("pc105ru.csv")
    }

    enum class BINDING {
        UP,
        DOWN,
        RIGHT,
        LEFT,
        TAB,
        ENTER,
        BACKSPACE,
        NO_MATCH
    }

    fun toChar(): Char {
        return keycode.toChar()
    }

    fun toLowercaseChar(): Char {
        return keycode.toChar().lowercaseChar()
    }

    fun normalize(): Char {
        return pc105ru.get(keycode.toChar().lowercaseChar())
    }
}
