package silver.ore.core.generator

import silver.ore.core.ClusterId

data class ClusterOreGeneratorId(val version: Int = 1, val seed: Long, val clusterId: ClusterId) {
}
