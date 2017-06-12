/**
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.xtext.calc.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.xtext.calc.webCalc.Calculation

@RunWith(XtextRunner)
@InjectWith(CalculatorInjectorProvider)
class CalculatorParsingTest {
	
	@Inject 	ParseHelper<Calculation> parseHelper
	
	@Test
	def void loadModel() {
		val result = parseHelper.parse('''
			/** Calculates the area of a square. */
			let square(a): pow(a, 2)
			
			/** Calculates the area of a cirecle based on the radius argument. */
			let circle(r): PI * pow(r, 2)
			
			/** Returns with the volume of a cube. */
			let cube(a): pow(a, 3) 
			
			/** Calculates the volume of a sphere. */
			let sphere(r): (4 / 3)  * PI * pow(r, 3)
			
			let a: 10
			let r: a / 2
			
			let aSquare: square(a)
			let aCircle: circle(r)
			
			/** Evaluate the value of the area difference by hitting Shift + Enter. */
			aSquare - aCircle
			
			cube(a) - sphere(r)
		''')
		Assert.assertNotNull(result)
		Assert.assertTrue(result.eResource.errors.isEmpty)
	}
}
