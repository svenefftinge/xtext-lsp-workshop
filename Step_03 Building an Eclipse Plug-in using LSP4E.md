# LSP4E Integration

To use our language server within Eclipse, we can utilize the new LSP4E project, which is the generic LSP supporting infrastructure for Eclipse.

## Create a plain Eclipse plug-in project

The first thing we need to do is to create a plug-in project, with an Activator. The easiest way to that is to use the Eclipse project wizard.

## Register our language server

Since our language server is implemented in Java, we could run it in the main eclipse process. However, to be more inline with the general usage pattern of LSP4E we will start anither java process from within this plug-in.

Hooking up a language server is pretty easy, we only need to create a subclass of `ProscessStreamConnectionProvider` and tell it about the command to be executed to launch the LS process.

```{Java}

public class CalculatorLanguageServer extends ProcessStreamConnectionProvider {

	public CalculatorLanguageServer() {
		List<String> commands = new ArrayList<>();
		commands.add("java");
		commands.add("-jar");
		Bundle bundle = Activator.getDefault().getBundle();
		URL resource = bundle.getResource("/language-server/calculator-language-server.jar");
		try {
			commands.add(new File(FileLocator.resolve(resource).toURI()).getAbsolutePath());
		} catch (URISyntaxException | IOException e) {
			throw new IllegalStateException(e);
		}
		setCommands(commands);
		setWorkingDirectory(Platform.getLocation().toOSString());
	}

	@Override
	public String toString() {
		return "Calculator Language Server: " + super.toString();
	}
}

```

As you can see we reference a jarthat should be located in the plugin itself. We enhanced the original gradle script in `org.xtext.calc.ide` to copy over the jar after it gets created with the following:

```{Gradle}
task buildLSP(type: Copy) {
	from 'build/libs/calculator-language-server.jar'
	into '../../org.xtext.calc.lsp4e/language-server'
}

buildLSP.dependsOn shadowJar
```

## Adding a TextMate Grammar

Since lexical syntax coloring is not provided by the language server protocol, we need to provide it manually. Therefore we have added a syntax defintion file, using the TextMate grammar language.

Have a look [here](org.xtext.calc.lsp4e/syntaxes/calc.tmLanguage.json)