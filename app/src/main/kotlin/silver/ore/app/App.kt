/*
 * This Kotlin source file was generated by the Gradle 'init' task.
 */
package silver.ore.app
import kotlin.random.Random

fun main() {
    val worlds = Array(1) { i -> World() }
    println(worlds[0].getCube(Random.nextInt(0,255), Random.nextInt(0,255), 128).display())
}