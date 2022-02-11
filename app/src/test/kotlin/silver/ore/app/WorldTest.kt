package silver.ore.app

import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.assertEquals
import kotlin.random.Random

class WorldTest {
    @Test fun testWorld() {
        val world = World()
        // randomize x and y
        val getCube: (Int) -> Cube = {
            world.getCube(Random.nextInt(0, 16), Random.nextInt(0, 16), it)
        }

        assertEquals("STONE:STONE", getCube(124).display())
        assertEquals("SOIL:SOIL", getCube(125).display())
        assertEquals("AIR:GRASS", getCube(128).display())
        assertEquals("AIR:AIR", getCube(130).display())
    }
}