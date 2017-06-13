## Packaging as a Language Server

A language server simply is a process that a tool can execute and communicate with over JSON-RPC. Most often the process' input and output streams are used to send over the messages, but once can also use a socket.

To start our language server we need to provide an executable. Xtext is running on the JVM, so we need to make it easy to start a Java process. I used the shadowJar gradle plugin to create a so called _uberJar_ for our application that contains all upstream dependencies. So we can run it by executing `java -jar calculator-language-server.jar`.

To apply the shadowJar plugin, we change the 'build.gradle' file in the parent project like this:

```
buildscript {
  …
  dependencies {
     classpath ‘com.github.jengelman.gradle.plugins:shadow:1.2.4'
     …

…
subprojects {
  …
  apply plugin: 'com.github.johnrengelman.shadow'
…
```

In addition we need to configure the shadowJar task in the *.ide project’s build.gradle:

```
shadowJar {
    baseName = 'calculator-language-server'
    classifier = null
    version = null
    manifest {
        attributes 'Main-Class': 'org.eclipse.xtext.ide.server.ServerLauncher'
    }
}
````

On the root level, you can now execute `.gradlew shadowJar`, which should do the build and produce a jar file that contains all upstream dependencies.

The specified main-class is shipped with Xtext and provides a standard way to start a language server that will run all languages that are on the classpath. In other words,with Xtext you can have one language server that can handle multiple Xtext languages. This is important if those languages link against each other. Also, editors usually communicate with a language server process through ‘standard in’ and ‘standard out’ which is the case here, too.
