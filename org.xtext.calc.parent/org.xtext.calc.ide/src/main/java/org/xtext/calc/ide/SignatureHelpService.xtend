/**
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
 
package org.xtext.calc.ide

import com.google.inject.Singleton
import org.eclipse.lsp4j.SignatureHelp
import org.eclipse.xtext.ide.server.signatureHelp.ISignatureHelpService
import org.eclipse.xtext.resource.XtextResource

/**
 * Implements signature help for the feature calls in the calculator DSL.
 */
@Singleton class SignatureHelpService implements ISignatureHelpService {
	
	override SignatureHelp getSignatureHelp(XtextResource resource, int offset) {
		return EMPTY
	}
	
}
