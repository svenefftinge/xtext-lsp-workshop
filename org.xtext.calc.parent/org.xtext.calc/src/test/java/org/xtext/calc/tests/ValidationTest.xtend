package org.xtext.calc.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Test
import org.junit.runner.RunWith
import org.xtext.calc.validation.CalculatorValidator
import org.xtext.calc.webCalc.Calculation
import org.xtext.calc.webCalc.WebCalcPackage

@InjectWith(CalculatorInjectorProvider)
@RunWith(XtextRunner)
class ValidationTest {

	@Inject ParseHelper<Calculation> parser
	@Inject ValidationTestHelper validator

	@Test def void testArgumentsNotExported_01() {
		val model = parser.parse(''' 
			let foo(a) : a * a
			foo
		''')
		validator.assertError(model, WebCalcPackage.Literals.FEATURE_CALL,
			CalculatorValidator.FUNCTION_CALL_ARGUMENTS_MISSING)
	}

	@Test def void testArgumentsNotExported_02() {
		val model = parser.parse(''' 
			let foo(a) : a * a
			foo(21)
		''')
		validator.assertNoErrors(model)
	}

	@Test def void testArgumentsNotExported_03() {
		val model = parser.parse(''' 
			let foo(a) : a * a
			foo(1,2)
		''')
		validator.assertError(model, WebCalcPackage.Literals.FEATURE_CALL,
			CalculatorValidator.FUNCTION_CALL_ARGUMENTS_MISSING)
	}

}
