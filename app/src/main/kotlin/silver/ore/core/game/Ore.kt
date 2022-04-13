package silver.ore.core.game

import silver.ore.core.Material

open class Ore(private val metal: Material) : Item() {
    init {
        if (!metal.isMetal()) {
            throw IllegalArgumentException("$metal is not metal")
        }
    }
    override fun getName(): String {
        when (metal) {
            Material.GOLD -> {
                return "Native gold" // Golden ore?
            }
            Material.SILVER -> {
                return "Acanthite"
            }
            Material.IRON -> {
                return "Hematite"
            }
            Material.TIN -> {
                return "Cassiterite"
            }
            Material.COPPER -> {
                return "Chalcocite"
            }
        }
        return "Unknown ore"
    }
    override fun display(): Char {
        when (metal) {
            Material.GOLD -> {
                return 'g'
            }
            Material.SILVER -> {
                return '$'
            }
            Material.IRON -> {
                return 'i'
            }
            Material.TIN -> {
                return 't'
            }
            Material.COPPER -> {
                return 'o'
            }
        }
        return 'O'
    }
}
