# Setup

Before we can go into any excercises we need to make sure that you have the repository cloned and that your machine is setup properly. Specifically you need to have the following installed:

## Clone the repository and run the  build

Make sure you have a local copy of this repository.
To build it, please go into `org.xtext.calc.parent` and run:
```
   ./gradlew build
```

## Eclipse Oxygen, with Xtext SDK 2.12, LSP4E 0.2 and Buildship

Make sure you have a Java 8 JDK installed on your machine. Also we need to install
an Eclipse Oxygen distribution with Xtext at buildship installed.
You can find a distribution that includes everything you need below:

- [Linux GTK 32 Bit](https://hudson.eclipse.org/packaging/job/oxygen.epp-tycho-build/318/artifact/org.eclipse.epp.packages/archive/20170615-0600_eclipse-dsl-oxygen-RC4-linux.gtk.x86.tar.gz)
- [Linux GTK 64 Bit](https://hudson.eclipse.org/packaging/job/oxygen.epp-tycho-build/318/artifact/org.eclipse.epp.packages/archive/20170615-0600_eclipse-dsl-oxygen-RC4-linux.gtk.x86_64.tar.gz)
- [OS X](https://hudson.eclipse.org/packaging/job/oxygen.epp-tycho-build/318/artifact/org.eclipse.epp.packages/archive/20170615-0600_eclipse-dsl-oxygen-RC4-macosx.cocoa.x86_64.dmg)
- [Windows 32 Bit](https://hudson.eclipse.org/packaging/job/oxygen.epp-tycho-build/318/artifact/org.eclipse.epp.packages/archive/20170615-0600_eclipse-dsl-oxygen-RC4-win32.win32.x86.zip)
- [Windows 64 Bit](https://hudson.eclipse.org/packaging/job/oxygen.epp-tycho-build/318/artifact/org.eclipse.epp.packages/archive/20170615-0600_eclipse-dsl-oxygen-RC4-win32.win32.x86_64.zip)

Please unzip and start the downloaded Eclipse.
You can now import the eclipse projects, by using the `Import Existing Projects`-Wizard.
You might need to do a clean build after importing.

## Set the target platform

The LSP4E plug.in needs additional plugins on the classpath, which you need to add to the target platform.
To do so, open the `Preferences` and therein `Plug-in Development/Target Platform`.

You should see an entry called `LSP4E Target Platform`. Please activate and apply.

## Start the language server

We have configured all the clients to connect to the language server via a socket. 
You can launch the server by running the `Run Language Server` launch config from within Eclipse.

## Run the clients

### LSP4E - Eclipse LSP Support

The project `org.xtext.calc.lsp4e` contains a plug-in fro LSP4E that registers a language server for our calculator example.
You can run it using the launch config `Run LSP4E plug-in`.

### Theia

To see the language server running in [Theia](https://github.com/theia-ide/theia), you need to execute a gradle task:
```
 ./gradlew startTheia
```

### VsCode

To see the language server running in VSCode, you need to execute the following gradle task.
```
 ./gradlew startCode
```

Also you need to have VS Code installed on your system.
