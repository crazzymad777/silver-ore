package silver.ore.app

enum class Material {
    GRASS {
        override fun isSolid(): Boolean {
            return false
        }
    },
    WOOD,
    STONE,
    AIR {
        override fun isSolid(): Boolean {
            return false
        }
    },
    SOIL;

    open fun isSolid(): Boolean {
        return true;
    }
}
