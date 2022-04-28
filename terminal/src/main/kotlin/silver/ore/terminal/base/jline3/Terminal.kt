package silver.ore.terminal.base.jline3

import org.jline.terminal.Attributes
import org.jline.terminal.Terminal
import org.jline.terminal.TerminalBuilder
import org.jline.utils.InfoCmp
import org.jline.utils.NonBlockingReader
import silver.ore.terminal.base.AbstractTerminal
import kotlin.system.exitProcess

class Terminal : AbstractTerminal() {
    private val builder: TerminalBuilder = TerminalBuilder.builder()
    val terminal: Terminal = builder.build()

    val reader: NonBlockingReader
    init {
        terminal.echo(false)
        val attributes = terminal.attributes
        attributes.setLocalFlag(Attributes.LocalFlag.ICANON, false)
        terminal.attributes = attributes

        reader = terminal.reader()
        if (terminal.type == "dumb-color" || terminal.type == "dumb") {
            terminal.writer().println("Your terminal is ${terminal.type}. Continue to work? (y/n)")
            terminal.flush()
            var integer: Int
            var char: Char
            do {
                integer = reader.read()
                char = integer.toChar().lowercaseChar()
            } while(integer >= 0 && char != 'y' && char != 'n')

            if (integer < 0 || char == 'n') {
                exitProcess(0)
            }
        }
    }

    override fun getType(): String {
        return terminal.type
    }

    override fun clear() {
        terminal.puts(InfoCmp.Capability.clear_screen)
        terminal.flush()
    }

    override fun builder(): TextBuilder {
        return TextBuilder(terminal)
    }
}
