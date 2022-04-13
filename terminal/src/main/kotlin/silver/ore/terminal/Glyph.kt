package silver.ore.terminal

import org.jline.utils.Colors
import silver.ore.core.Cube
import silver.ore.core.Material

class Glyph(val cube: Cube) {
    private val max = Colors.DEFAULT_COLORS_256.size
    var foreground: AbstractColor = AbstractColor(255, 255, 255, max)
    val background: AbstractColor = AbstractColor(0, 0, 0, max)
    val char: Char = cube.display()

    private fun getMaterialForegroundColor(material: Material): AbstractColor {
        when (material) {
            Material.GRASS -> {
                return AbstractColor(0, 255, 0, max)
            }
            Material.WOOD -> {
                return AbstractColor(255, 255, 0, max)
            }
            Material.STONE -> {
                return AbstractColor(128, 128, 128, max)
            }
            Material.WATER -> {
                return AbstractColor(0,95,175, max)
            }
            Material.SAND -> {
                return AbstractColor(255, 255, 255, max)
            }
            Material.GOLD -> {
                return AbstractColor(255, 255, 128, max)
            }
            Material.SILVER -> {
                return AbstractColor(200, 200, 200, max)
            }
            Material.IRON -> {
                return AbstractColor(255, 255, 255, max)
            }
            Material.COPPER -> {
                return AbstractColor(184, 115, 51, max)
            }
            Material.VOID -> {
                return AbstractColor(0, 0, 0, max)
            }
            Material.SILT -> {
                return AbstractColor(0,100,0, max)
            }
            Material.TIN -> {
                return AbstractColor(145,145,145, max)
            }
            Material.SOIL -> {
                return AbstractColor(184, 115, 51, max)
            }
            else -> return AbstractColor(255, 255, 255, max)
        }
    }

    fun getColor(): AbstractColor {
        val item = cube.getItem()
        if (item == null) {
            if (cube.wall == Material.AIR) {
                if (cube.floor == Material.GRASS) {
                    return AbstractColor(0, 255, 0, max)
                } else if (cube.floor == Material.WOOD) {
                    return AbstractColor(255, 255, 0, max)
                }
                return AbstractColor(255, 255, 255, max)
            }
            if (cube.wall == Material.WOOD) {
                return AbstractColor(255, 255, 0, max)
            }
            return getMaterialForegroundColor(cube.wall)
        }
        return AbstractColor(255, 0, 0, max)
    }

    init {
        foreground = getColor()
    }
}
