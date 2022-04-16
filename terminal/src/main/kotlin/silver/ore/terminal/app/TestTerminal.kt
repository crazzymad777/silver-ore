package silver.ore.terminal.app

import org.jline.terminal.TerminalBuilder
import org.jline.utils.AttributedStringBuilder
import org.jline.utils.AttributedStyle
import silver.ore.core.game.Material
import silver.ore.terminal.base.RgbColor

fun main() {
    val hashMap = HashMap<Material, RgbColor>()
    val builder = TerminalBuilder.builder()
    val terminal = builder.build()

    val array = arrayOf(Material.GRASS, Material.COPPER, Material.GOLD, Material.TIN,
                        Material.IRON, Material.SILT, Material.SOIL, Material.SILVER,
                        Material.WATER, Material.SAND)

    for (material in array) {
        hashMap[material] = Glyph.getMaterialForegroundColor(material)
    }

    for (materialColor in hashMap) {
        val coloredBuilder = AttributedStringBuilder()
        val ansi = coloredBuilder.style(
            AttributedStyle.DEFAULT.foreground(materialColor.value.r, materialColor.value.g,materialColor.value.b)
        ).append("${materialColor.key}: ${materialColor.value}").toAnsi(terminal)
        terminal.writer().println(ansi)
        terminal.writer().flush()
    }
}
