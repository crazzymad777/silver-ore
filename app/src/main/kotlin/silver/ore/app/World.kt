package silver.ore.app

class World {
    val cache = HashMap<Any, Any>()
    val seed: Int = 0
    private val chunks = Array(16*16*16) { i -> Chunk(i) }
    fun getChunk(x: Int, y: Int, z: Int): Chunk {
        return chunks[x+y*16+z*16*16]
    }
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
