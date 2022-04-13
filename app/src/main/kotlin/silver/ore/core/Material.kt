package silver.ore.core

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
    WATER,
    SAND,
    SOIL,
    SILT,
    GOLD {
        override fun isMetal(): Boolean {
            return true
        }
    },
    SILVER {
        override fun isMetal(): Boolean {
            return true
        }
    },
    IRON {
        override fun isMetal(): Boolean {
            return true
        }
    },
    TIN {
        override fun isMetal(): Boolean {
            return true
        }
    },
    COPPER {
        override fun isMetal(): Boolean {
            return true
        }
    },
    VOID;

    open fun isSolid(): Boolean {
        return true
    }
    open fun isMetal(): Boolean {
        return false
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
        } else if (this == AIR) {
            return ' '
        } else if (this == VOID) {
            return '!'
        } else if (this == WATER) {
            return '~'
        } else if (this == SILT) {
            return 'z'
        } else if (this == SAND) {
            return '.'
        }
        return ' '
    }
}
