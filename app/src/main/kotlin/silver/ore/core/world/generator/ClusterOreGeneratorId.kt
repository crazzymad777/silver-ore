package silver.ore.core.world.generator

import silver.ore.core.world.ClusterId

data class ClusterOreGeneratorId(val version: Int = 1, val seed: Long, val clusterId: ClusterId) {
}
