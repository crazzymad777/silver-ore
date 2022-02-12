package silver.ore.app

class Generator {
    fun getCube(x: Int, y: Int, z: Int): Cube {
        var floor: Material = Material.AIR
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
}