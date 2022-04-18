package silver.ore.terminal.base

abstract class AbstractDisplay {
    abstract fun put(x: Int, y: Int, glyph: Glyph)
    abstract fun put(x: Int, y: Int, glyphs: Array<Glyph>)
    abstract fun read(): Key
    abstract fun clear()
    abstract fun reset()
    abstract fun update()
    abstract fun getWidth(): Int
    abstract fun getHeight(): Int
    abstract fun resize(width: Int, height: Int)
}
