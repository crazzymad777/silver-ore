package silver.ore.core

data class ClusterId(private val x: Long, private val y: Long) {
    init {
        if (x < 0) {
            throw IllegalArgumentException("invalid x: $x")
        }

        if (y < 0) {
            throw IllegalArgumentException("invalid y: $y")
        }

        if (x > maxClusterId) {
            throw IllegalArgumentException("invalid x: $x")
        }

        if (y > maxClusterId) {
            throw IllegalArgumentException("invalid y: $y")
        }
    }

    override fun toString(): String {
        // Show signed clusterId
        val x = getSignedX()
        val y = getSignedY()
        return "ClusterId(x=$x, y=$y)"
    }

    fun getSignedX(): Long {
        val half = maxClusterId/2
        return if (x < half) {
            this.x
        } else {
            (-this.x+half*2)*-1-2
        }
    }

    fun getSignedY(): Long {
        val half = maxClusterId/2
        return if (x < half) {
            this.x
        } else {
            (-this.x+half*2)*-1-2
        }
    }

    fun getUnsignedX(): Long {
        return x
    }

    fun getUnsignedY(): Long {
        return y
    }

    companion object {
        const val maxClusterId = 72057594037927935

        fun signedClusterId(x: Long, y: Long): ClusterId {
            val unsignedX = if (x < 0) {
                maxClusterId+x+1
            } else if (x > maxClusterId) {
                x - maxClusterId - 1
            } else {
                x
            }
            val unsignedY = if (y < 0) {
                maxClusterId+y+1
            } else if (y > maxClusterId) {
                y - maxClusterId - 1
            } else {
                y
            }
            return ClusterId(unsignedX, unsignedY)
//            val half = maxClusterId/2
//
//            val unsignedX = if (x < 0) {
//                maxClusterId+x+1
//            } else if (x < half) {
//                x
//            } else {
//                (-x+half*2)*-1-2
//            }
//
//            val unsignedY = if (y < 0) {
//                maxClusterId+y+1
//            } else if (y < half) {
//                y
//            } else {
//                (-y+half*2)*-1-2
//            }
//
//            return if (unsignedX >= 0 && unsignedY >= 0) {
//                ClusterId(unsignedX, unsignedY)
//            } else {
//                signedClusterId(unsignedX, unsignedY)
//            }
        }
    }

    fun getNeighbourhood(): Array<ClusterId> {
        return arrayOf(signedClusterId(x, y-1),
            signedClusterId(x+1, y-1),
            signedClusterId(x+1, y),
            signedClusterId(x+1, y+1),
            signedClusterId(x, y+1),
            signedClusterId(x-1, y+1),
            signedClusterId(x-1, y),
            signedClusterId(x-1, y-1))
    }
}
