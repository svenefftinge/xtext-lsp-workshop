/**
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.xtext.calc.validation

import org.eclipse.xtext.validation.Check
import org.xtext.calc.webCalc.FeatureCall

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class CalculatorValidator extends AbstractCalculatorValidator {
	
	public static val FUNCTION_CALL_ARGUMENTS_MISSING = 'function_call_arguments_missing'

	@Check
	def checkFunctionCallArgumentsAreMissing(FeatureCall call) {
		
	}
	
}
