package silver.ore.terminal

import org.jline.terminal.Attributes
import org.jline.terminal.Terminal
import org.jline.terminal.TerminalBuilder
import org.jline.utils.InfoCmp
import org.jline.utils.NonBlockingReader

class JLineTerminal : AbstractTerminal() {
    private val builder: TerminalBuilder = TerminalBuilder.builder()
    private val terminal: Terminal = builder.build()

    init {
        terminal.echo(false)
        val attributes = terminal.attributes
        attributes.setLocalFlag(Attributes.LocalFlag.ICANON, false)
        terminal.attributes = attributes
    }
    val reader: NonBlockingReader = terminal.reader()

    override fun getType(): String {
        return terminal.type
    }

    override fun clear() {
        terminal.puts(InfoCmp.Capability.clear_screen)
        terminal.flush()
    }

    override fun builder(): JLineTextBuilder {
        return JLineTextBuilder()
    }
}
