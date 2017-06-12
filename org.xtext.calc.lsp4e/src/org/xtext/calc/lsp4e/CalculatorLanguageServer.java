package org.xtext.calc.lsp4e;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.lsp4e.server.ProcessStreamConnectionProvider;
import org.eclipse.core.runtime.Platform;

public class CalculatorLanguageServer extends ProcessStreamConnectionProvider {

	public CalculatorLanguageServer() {
		List<String> commands = new ArrayList<>();
		commands.add("java");
		commands.add("-jar");
		commands.add("/Users/efftinge/Documents/Eclipse/xtext-lsp-workshop/org.xtext.calc.parent/org.xtext.calc.ide/build/libs/calculator-language-server.jar");
		setCommands(commands);
		setWorkingDirectory(Platform.getLocation().toOSString());
	}

	@Override
	public String toString() {
		return "Calculator Language Server: " + super.toString();
	}
}
