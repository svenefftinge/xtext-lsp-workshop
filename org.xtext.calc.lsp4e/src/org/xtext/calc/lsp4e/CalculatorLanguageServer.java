package org.xtext.calc.lsp4e;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Platform;
import org.eclipse.lsp4e.server.ProcessStreamConnectionProvider;
import org.eclipse.lsp4e.server.StreamConnectionProvider;
import org.eclipse.lsp4j.jsonrpc.messages.Message;
import org.eclipse.lsp4j.services.LanguageServer;
import org.osgi.framework.Bundle;

public class CalculatorLanguageServer implements StreamConnectionProvider {
	
	private final static boolean SOCKET_MODE = true;
	private StreamConnectionProvider delegate;

	public CalculatorLanguageServer() {
		if (SOCKET_MODE) {
			this.delegate = new SocketStreamConnectionProvider(5007) {
			};
		} else {
			List<String> commands = new ArrayList<>();
			commands.add("java");
			commands.add("-Xdebug");
			commands.add("-Xrunjdwp:server=y,transport=dt_socket,address=4001,suspend=n,quiet=y");
			commands.add("-jar");
			Bundle bundle = Activator.getDefault().getBundle();
			URL resource = bundle.getResource("/language-server/calculator-language-server-jar");
			try {
				commands.add(new File(FileLocator.resolve(resource).toURI()).getAbsolutePath());
			} catch (Exception e) {
				throw new IllegalStateException(e);
			}
			this.delegate = new ProcessStreamConnectionProvider(commands, Platform.getLocation().toOSString()) {};
		}
	}

	public void start() throws IOException {
		delegate.start();
	}

	public InputStream getInputStream() {
		return delegate.getInputStream();
	}

	public OutputStream getOutputStream() {
		return delegate.getOutputStream();
	}

	public Object getInitializationOptions(URI rootUri) {
		return delegate.getInitializationOptions(rootUri);
	}

	public void stop() {
		delegate.stop();
	}

	public void handleMessage(Message message, LanguageServer languageServer, URI rootURI) {
		delegate.handleMessage(message, languageServer, rootURI);
	}


	@Override
	public String toString() {
		return "Calculator Language Server: " + super.toString();
	}
}
