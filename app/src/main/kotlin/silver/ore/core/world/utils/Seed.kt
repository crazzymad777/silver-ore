package silver.ore.core.world.utils

import java.nio.ByteBuffer
import java.security.MessageDigest

class Seed {
    companion object {
        fun make(str: String): Long {
            val bytes = str.toByteArray()
            val md = MessageDigest.getInstance("SHA-256")
            val digest = md.digest(bytes)
            val wrapped: ByteBuffer = ByteBuffer.wrap(digest)
            return wrapped.getLong(0)
        }
    }
}
