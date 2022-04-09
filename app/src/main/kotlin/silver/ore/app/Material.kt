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
    open fun display(): Char {
        if (this == GRASS) {
            return 'g'
        } else if (this == WOOD) {
            return 'w'
        } else if (this == STONE) {
            return 'S'
        } else if (this == SOIL) {
            return 's'
        }else if (this == AIR) {
            return '_'
        }
        return ' '
    }
}
