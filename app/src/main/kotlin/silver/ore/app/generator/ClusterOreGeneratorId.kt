package silver.ore.app.generator

import silver.ore.app.ClusterId

data class ClusterOreGeneratorId(val version: Int = 1, val seed: Long, val clusterId: ClusterId) {
}
