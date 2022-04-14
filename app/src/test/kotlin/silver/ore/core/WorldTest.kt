package silver.ore.core

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import silver.ore.core.utils.GlobalCubeCoordinates
import kotlin.random.Random

class WorldTest {
    private val flatWorld = World(WorldConfig(generatorName = "flat"))

    @Test fun testFlatWorld() {
        // randomize x and y
        val getCube: (Long) -> Cube = {
            flatWorld.getCube(GlobalCubeCoordinates(Random.nextLong(0, 255), Random.nextLong(0, 255), it))
        }

        assertEquals("STONE:STONE", getCube(124).displayTest())
        assertEquals("SOIL:SOIL", getCube(125).displayTest())
        assertEquals("AIR:GRASS", getCube(128).displayTest())
        assertEquals("AIR:AIR", getCube(130).displayTest())
    }

    @Test fun testFlatWorldMoreTimes() {
        for (x in 0..10) {
            testFlatWorld()
        }
    }
}