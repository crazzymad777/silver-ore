package silver.ore.app

import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.assertEquals
import kotlin.random.Random

class WorldTest {
    private val flatWorld = World(WorldConfig(generatorName = "flat"))

    @Test fun testFlatWorld() {
        // randomize x and y
        val getCube: (Int) -> Cube = {
            flatWorld.getCube(Random.nextInt(0, 255), Random.nextInt(0, 255), it)
        }

        assertEquals("STONE:STONE", getCube(124).display())
        assertEquals("SOIL:SOIL", getCube(125).display())
        assertEquals("AIR:GRASS", getCube(128).display())
        assertEquals("AIR:AIR", getCube(130).display())
    }

    @Test fun testFlatWorldMoreTimes() {
        for (x in 0..10) {
            testFlatWorld();
        }
    }
}