package silver.ore.terminal.base.jline3

import org.jline.keymap.BindingReader
import org.jline.keymap.KeyMap
import org.jline.keymap.KeyMap.key
import org.jline.terminal.Terminal
import org.jline.utils.InfoCmp
import org.jline.utils.NonBlockingReader
import silver.ore.terminal.base.Key

class Keyboard(val terminal: Terminal, reader: NonBlockingReader) {
    val keyMap = KeyMap<Key.BINDING>()
    init {
        // bindings work perfectly for "linux" but not work for "xterm"
        keyMap.bind(Key.BINDING.ENTER, key(terminal, InfoCmp.Capability.key_enter))
        keyMap.bind(Key.BINDING.RIGHT, key(terminal, InfoCmp.Capability.key_right))
        keyMap.bind(Key.BINDING.LEFT, key(terminal, InfoCmp.Capability.key_left))
        keyMap.bind(Key.BINDING.UP, key(terminal, InfoCmp.Capability.key_up))
        keyMap.bind(Key.BINDING.DOWN, key(terminal, InfoCmp.Capability.key_down))
        keyMap.bind(Key.BINDING.BACKSPACE, key(terminal, InfoCmp.Capability.key_backspace))

        // works for "xterm" too
        keyMap.bind(Key.BINDING.TAB, String(byteArrayOf(9)))
        keyMap.bind(Key.BINDING.ENTER, String(byteArrayOf(10)))
        keyMap.bind(Key.BINDING.BACKSPACE, String(byteArrayOf(127)))
        keyMap.bind(Key.BINDING.UP, String(byteArrayOf(27, 91, 65)))
        keyMap.bind(Key.BINDING.DOWN, String(byteArrayOf(27, 91, 66)))
        keyMap.bind(Key.BINDING.RIGHT, String(byteArrayOf(27, 91, 67)))
        keyMap.bind(Key.BINDING.LEFT, String(byteArrayOf(27, 91, 68)))

        keyMap.nomatch = Key.BINDING.NO_MATCH
        keyMap.unicode = Key.BINDING.NO_MATCH
    }

    private val bindingReader = BindingReader(reader)

    fun fetch(): Key {
        val binding = bindingReader.readBinding(keyMap)
        if (binding == Key.BINDING.NO_MATCH) {
            return Key(binding, bindingReader.readCharacter())
        }
        return Key(binding)
    }
}
