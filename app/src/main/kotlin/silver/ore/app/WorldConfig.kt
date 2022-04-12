package silver.ore.app

data class WorldConfig(val seed: Long = System.currentTimeMillis() / 1000L, val generatorName: String = "flat") {

}
