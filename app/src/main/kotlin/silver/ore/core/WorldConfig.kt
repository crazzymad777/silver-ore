package silver.ore.core

data class WorldConfig(val seed: Long = System.currentTimeMillis() / 1000L,
                       val generatorName: String = "flat",
                       val enableNegativeCoordinates: Boolean = false)
