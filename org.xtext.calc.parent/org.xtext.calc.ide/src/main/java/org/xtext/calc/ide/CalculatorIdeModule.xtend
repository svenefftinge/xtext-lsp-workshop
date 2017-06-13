/**
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.xtext.calc.ide

import org.eclipse.xtext.ide.server.signatureHelp.ISignatureHelpService

/**
 * Use this class to register ide components.
 */
class CalculatorIdeModule extends AbstractCalculatorIdeModule {
	
	def Class<? extends ISignatureHelpService> bindISignatureHelpService() {
		return SignatureHelpService
	}
	
}
