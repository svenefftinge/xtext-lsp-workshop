package org.xtext.calc.lsp4e;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

import org.eclipse.lsp4e.server.StreamConnectionProvider;

public class SocketStreamConnectionProvider implements StreamConnectionProvider {

	private int port;
	private Socket socket;
	private InputStream inputStream;
	private OutputStream outputStream;

	public SocketStreamConnectionProvider(int port) {
		this.port = port;
	}

	@Override
	public void start() throws IOException {
		this.socket = new Socket("localhost", port);
		inputStream = new BufferedInputStream(socket.getInputStream());
		outputStream = new BufferedOutputStream(socket.getOutputStream());
	}

	@Override
	public InputStream getInputStream() {
		return inputStream;
	}

	@Override
	public OutputStream getOutputStream() {
		return outputStream;
	}

	@Override
	public void stop() {
		if (socket != null) {
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
