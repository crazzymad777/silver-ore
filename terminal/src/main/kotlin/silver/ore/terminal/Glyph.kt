package silver.ore.terminal

import silver.ore.core.Cube
import silver.ore.core.Material

class Glyph(val cube: Cube) {
    var foreground: RgbColor = RgbColor(255, 255, 255)
    val background: RgbColor = RgbColor(0, 0, 0)
    val char: Char = cube.display()

    private fun getMaterialForegroundColor(material: Material): RgbColor {
        when (material) {
            Material.GRASS -> {
                return RgbColor(0, 255, 0)
            }
            Material.WOOD -> {
                return RgbColor(255, 255, 0)
            }
            Material.STONE -> {
                return RgbColor(128, 128, 128)
            }
            Material.WATER -> {
                return RgbColor(0,95,175)
            }
            Material.SAND -> {
                return RgbColor(255, 255, 0)
            }
            Material.GOLD -> {
                return RgbColor(255, 255, 0)
            }
            Material.SILVER -> {
                return RgbColor(200, 200, 200)
            }
            Material.IRON -> {
                return RgbColor(255, 255, 255)
            }
            Material.COPPER -> {
                return RgbColor(184, 115, 51)
            }
            Material.VOID -> {
                return RgbColor(0, 0, 0)
            }
            Material.SILT -> {
                return RgbColor(0,100,0)
            }
            Material.TIN -> {
                return RgbColor(145,145,145)
            }
            Material.SOIL -> {
                return RgbColor(184, 115, 51)
            }
            else -> return RgbColor(255, 255, 255)
        }
    }

    fun getColor(): RgbColor {
        val item = cube.getItem()
        if (item == null) {
            if (cube.wall == Material.AIR) {
                if (cube.floor == Material.GRASS) {
                    return RgbColor(0, 255, 0)
                } else if (cube.floor == Material.WOOD) {
                    return RgbColor(255, 255, 0)
                }
                return getMaterialForegroundColor(cube.floor)
            }
            if (cube.wall == Material.WOOD) {
                return RgbColor(255, 255, 0)
            }

            return getMaterialForegroundColor(cube.wall)
        }
        return RgbColor(255, 0, 0)
    }

    init {
        foreground = getColor()
    }
}
