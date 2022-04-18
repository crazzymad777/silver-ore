package silver.ore.terminal.base

data class Key(val binding: BINDING = BINDING.NO_MATCH, val keycode: Int = 0) {
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
}
