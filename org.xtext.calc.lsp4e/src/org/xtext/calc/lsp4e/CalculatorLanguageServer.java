package org.xtext.calc.lsp4e;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Platform;
import org.eclipse.lsp4e.server.ProcessStreamConnectionProvider;
import org.osgi.framework.Bundle;

public class CalculatorLanguageServer extends ProcessStreamConnectionProvider {

	public CalculatorLanguageServer() {
		List<String> commands = new ArrayList<>();
		commands.add("java");
		commands.add("-Xdebug");
		commands.add("-Xrunjdwp:server=y,transport=dt_socket,address=4001,suspend=n,quiet=y");
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
