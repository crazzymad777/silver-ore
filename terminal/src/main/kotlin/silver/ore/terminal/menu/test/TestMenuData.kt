package silver.ore.terminal.menu.test

import silver.ore.core.game.Material
import silver.ore.terminal.app.Glyph
import silver.ore.terminal.base.RgbColor

class TestMenuData {
    val map = HashMap<Material, RgbColor>()
    val array = arrayOf(
        Material.GRASS, Material.COPPER, Material.GOLD, Material.TIN,
        Material.IRON, Material.SILT, Material.SOIL, Material.SILVER,
        Material.WATER, Material.SAND)

    init {
        for (material in array) {
            map[material] = Glyph.getMaterialForegroundColor(material)
        }
    }
}
