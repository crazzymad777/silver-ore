package silver.ore.terminal.utils

import com.github.doyaaaaaken.kotlincsv.dsl.csvReader
import com.google.common.io.Resources;

class KeyboardLayout(resourcePath: String) {
    private val fileContent: String = Resources.getResource(resourcePath).readText()
    private val rows: List<List<String>> = csvReader {
        delimiter = ':'
    }.readAll(fileContent)

    private val pairs = Array(rows.size) {
        Pair(rows[it][0][0], rows[it][1][0])
    }
    private val map = mapOf(*pairs)

    fun get(char: Char): Char {
        return map[char] ?: char
    }
}
