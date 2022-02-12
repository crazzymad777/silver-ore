package silver.ore.app

enum class Generator {
    FLAT {
        override fun getCube(x: Int, y: Int, z: Int): Cube {
            val floor: Material
            var wall: Material = Material.AIR
            if (z == 128) {
                floor = Material.GRASS;
            } else if (z <= 124) {
                wall = Material.STONE;
                floor = Material.STONE;
            } else if (z > 128) {
                wall = Material.AIR;
                floor = Material.AIR;
            } else {
                wall = Material.SOIL;
                floor = Material.SOIL;
            }
            return Cube(wall, floor);
        }
    },
    i1 { // in-dev generator number one
        override fun getCube(x: Int, y: Int, z: Int): Cube {
            val floor: Material
            var wall: Material = Material.AIR
            if (z == 128) {
                floor = Material.GRASS;
            } else if (z <= 124) {
                wall = Material.STONE;
                floor = Material.STONE;
            } else if (z > 128) {
                wall = Material.AIR;
                floor = Material.AIR;
            } else {
                wall = Material.SOIL;
                floor = Material.SOIL;
            }
            return Cube(wall, floor);
        }
    };
    abstract fun getCube(x: Int, y: Int, z: Int): Cube
}
