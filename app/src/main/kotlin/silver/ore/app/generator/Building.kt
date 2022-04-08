package silver.ore.app.generator

import kotlin.random.Random

class Building(random: Random) {
    val x: Int = random.nextInt()%256;
    val y: Int = random.nextInt()%256;
    val z: Int = random.nextInt()%256;
    val width: Int = random.nextInt()%4+4
    val height: Int = random.nextInt()%4+4
    val basement: Boolean = random.nextBoolean()
    val loft: Boolean = random.nextBoolean()
}
