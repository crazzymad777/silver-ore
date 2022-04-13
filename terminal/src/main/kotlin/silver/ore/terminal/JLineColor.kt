package silver.ore.terminal

import org.jline.utils.Colors

class JLineColor(color: AbstractColor) {
    companion object {
        private val map = HashMap<AbstractColor, JLineColor>()

        fun obtainColor(color: AbstractColor): JLineColor {
            var c = map[color]
            if (c != null) {
                return c
            }
            c = JLineColor(color)
            map[color] = c
            return c
        }
    }

    private val i = Colors.roundRgbColor(color.r, color.g, color.b, color.max)

    fun getIntColor(): Int {
            return i
    }
}
