/*
 * This file was generated by the Gradle 'init' task.
 */

plugins {
    id("silver.ore.kotlin-application-conventions")
}

application {
    // Define the main class for the application.
    mainClass.set("silver.ore.app.AppKt")
}

dependencies {
    implementation("org.jline:jline-terminal:3.21.0")
    implementation(project(":app"))
}

