package silver.ore.app

import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.assertEquals
import kotlin.random.Random

class WorldTest {
    private val world = World()

    @Test fun testWorld() {
        // randomize x and y
        val getCube: (Int) -> Cube = {
            world.getCube(Random.nextInt(0, 255), Random.nextInt(0, 255), it)
        }

        assertEquals("STONE:STONE", getCube(124).display())
        assertEquals("SOIL:SOIL", getCube(125).display())
        assertEquals("AIR:GRASS", getCube(128).display())
        assertEquals("AIR:AIR", getCube(130).display())
    }

    @Test fun testWorldMoreTimes() {
        for (x in 0..10) {
            testWorld();
        }
    }
}