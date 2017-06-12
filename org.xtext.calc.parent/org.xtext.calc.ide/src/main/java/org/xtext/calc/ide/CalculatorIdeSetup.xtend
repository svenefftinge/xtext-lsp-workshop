/**
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.xtext.calc.ide

import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2
import org.xtext.calc.CalculatorRuntimeModule
import org.xtext.calc.CalculatorStandaloneSetup

/**
 * Initialization support for running Xtext languages as language servers.
 */
class CalculatorIdeSetup extends CalculatorStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new CalculatorRuntimeModule, new CalculatorIdeModule))
	}
	
}
