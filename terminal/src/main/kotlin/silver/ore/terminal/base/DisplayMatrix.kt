package silver.ore.terminal.base

class DisplayMatrix(var width: Int, var height: Int) {
    var suspendMatrix: Boolean = false
    var matrix = Array(height) {
        Array(width) {
            Glyph()
        }
    }

    fun resize(width: Int, height: Int) {
        suspendMatrix = true
        matrix = Array(height) {
            Array(width) {
                Glyph()
            }
        }
        this.width = width
        this.height = height
        suspendMatrix = false
    }

    fun put(x: Int, y: Int, glyph: Glyph) {
        if (!suspendMatrix) {
            if (y in 0 until height) {
                if (x in 0 until width) {
                    matrix[y][x] = glyph
                }
            }
        }
    }

    fun put(x: Int, y: Int, glyphs: Array<Glyph>) {
        if (!suspendMatrix) {
            val row = matrix[y]
            for (i in x until glyphs.size + x) {
                row[i] = glyphs[i - x]
//                put(i, y, glyphs[i - x])
            }
        }
    }

    fun put(x: Int, y: Int, glyphs: List<Glyph>) {
        if (!suspendMatrix) {
            val row = matrix[y]
            for (i in x until glyphs.size + x) {
                row[i] = glyphs[i - x]
//                put(i, y, glyphs[i - x])
            }
        }
    }

    fun put(x: Int, y: Int, string: String) {
        if (!suspendMatrix) {
            for (i in x until string.length + x) {
                matrix[y][i] = Glyph(char = string[i - x])
//                put(i, y, Glyph(char = string[i - x]))
            }
        }
    }

    fun clear() {
        if (!suspendMatrix) {
            for (x in 0 until width) {
                for (y in 0 until height) {
                    matrix[y][x] = Glyph()
                }
            }
        }
    }
}
