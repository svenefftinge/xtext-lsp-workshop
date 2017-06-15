# Setup

Before we can go into any excercises we need to make sure that you have the repository cloned and that your machine is setup properly. Specifically you need to have the following installed:

## Eclipse Oxygen, with Xtext SDK 2.12, LSP4E 0.2 and Buildship

Make sure you have a Java 8 JDK installed on your machine.
- Eclipse download : https://www.eclipse.org/downloads/index-developer.php 
- Xtext update site : http://download.eclipse.org/modeling/tmf/xtext/updates/composite/releases/
- LSP4E update site : http://download.eclipse.org/lsp4e/snapshots/
- Buildship update site : http://download.eclipse.org/buildship/updates/e46/releases/2.x

## Requirements for the Theia example

### Node.js
Node.js (with npm) should be installed on the system and should be available from the path. Windows users can download an installer from [here](https://nodejs.org/dist/v7.9.0/). If you are on OS X, you can use [`homebrew`](https://brew.sh) to install Node.js and [nvm](https://github.com/creationix/nvm). Once you have `homebrew` installed on your system, execute the following commands to install Node.js.

```
brew install nvm
nvm install 7
nvm use 7
```

Verify your Node.js and npm installation with the following steps.
```
node -v && npm -v
```

### Compiling native modules
Theia uses native modules and also requires Python 2.x to be installed on the system when building the application.

On Windows, one can get all the [all-in-one packages](https://github.com/felixrieseberg/windows-build-tools) by running npm `install --global windows-build-tools` script. If you are facing with `EPERM: operation not permitted` or `permission denied` errors while building, testing or running the Theia integration then;
 - You don't have write access to the installation directory.
 - Try to run your command line (PowerShell, GitBash, Cygwin or whatever you are using) as an administrator.
 - The permissions in the NPM cache might get corrupted. Please try to run npm cache clean to fix them.

On OS X, one needs to install `Xcode` to the system. [Here](https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/#laptop-script) is a great step by step `Xcode` installation tutorial . Python 2.x can be downloaded and installed from [here](https://www.python.org/downloads/release/python-2713/).

# Run the examples

After cloning and importing the projects into your workspace you should see the three gradle projects, as well as the LSP4E plug-in in your workspace.

Next up you need to run the gradle build within the `org.xtext.calc.parent` folder. To do so, please execute the following commands:
```
cd org.xtext.calc.parent
./gradlew buildLSP
```

## Run LSP4E

You can now start the LSP4E plug-in using the preconfigured launch config _"Run LSP4E plug-in"_. It will spawn a new eclipse. Import the project "example-workspace/example-project" located in the project "org.xtext.calc.lsp4e".

You should be able to open the editors using the _generic editor_. The editor should provide some langauge features like, diagnostics, find references or content assist.

## Debugging the language server in LSP4E
The language server is executed in a separate java process. So if you want to debug it, you need to attach a debugger to it. We have prepared a launch config that will do that, it is called _'debug-language-server-lsp4e'_ and is listed in the favorites of the debug tool bar.

## Run Theia

Alternatively you can run the langauge server in Theia.
For that you need to execute the following commands:

```
cd theia-calc-extension
npm install
npm run build
npm run start
```

## Debugging the language server in Theia
You can attch a debugger to the language server executed by Theia, using the launch config 
 - _'debug-language-server-theia'_.
 To kill the process and start a new one you simply need to refresh the browser.

## Run VSCode
You need to run the gradle build within the `org.xtext.calc.parent` folder. To do so, please execute the following commands:
```
cd org.xtext.calc.parent
./gradlew startCode
```
The server is contained inside the VSCode extension and will start automatically.
