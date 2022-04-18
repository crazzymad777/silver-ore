package silver.ore.terminal.base

abstract class AbstractDisplay {
    abstract fun put(x: Int, y: Int, glyph: silver.ore.terminal.base.Glyph)
    abstract fun put(x: Int, y: Int, glyphs: Array<silver.ore.terminal.base.Glyph>)
    abstract fun read(): Key
    abstract fun clear()
    abstract fun reset()
    abstract fun update()
    abstract fun getWidth(): Int
    abstract fun getHeight(): Int
}
