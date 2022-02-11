package silver.ore.app

class Chunk(i: Int) {
    private val chunkId = i
    fun display(): String {
        return "chunk:$chunkId"
    }
}
