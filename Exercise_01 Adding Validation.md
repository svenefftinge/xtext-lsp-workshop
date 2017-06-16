# Exercise: Validate Function Calls

To get started, please checkout the branch called `Exercise_01`.

At this point you should have the projects checked out and should have been able to start one of the available editors to try the _Calculator DSL_. Here comes the first real exercise :) 
Our language allows you to call symbols defined elsewhere. Those definitions may define parameters. We need to validate any defintion reference to provide the correct number of arguments.

## Solution : Implement a Validation Rule

The Xtext generator already provided us with a stub, to put in validation rules. To add a check for all feature calls we need to add a check for them:

```{xtend}
    // the constant issue code, for our compiler check
	public static val FUNCTION_CALL_ARGUMENTS_MISSING = 'function_call_arguments_missing'

	@Check
	def checkFunctionCallArgumentsAreMissing(FeatureCall call) {
		// ... logic goes here
	}
```

It's a good idea to develop such enhancements in a test-driven way. Xtext provides good test utilities for most of these enhancements. Before we try to implement the check we should add one or more test cases that should initially fail.

To do so, you should create a fresh Xtend class Within the `org.xtext.calc` project's `src/test/java` source folder.
In the following you can find the code that includes three test cases for the cvalidation we want to create.

```{xtend}
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

```

## Full Solution

```{xtend}
	public static val FUNCTION_CALL_ARGUMENTS_MISSING = 'function_call_arguments_missing'

	@Check
	def checkFunctionCallArgumentsAreMissing(FeatureCall call) {
		switch f : call.feature {
			Definition case f.params.size !== call.args.size : {
				error('''The definition «f.name»(«f.params.join(', ')[name]») needs to be called with «f.params.size» arguments.''', 
						WebCalcPackage.Literals.FEATURE_CALL__FEATURE,
						FUNCTION_CALL_ARGUMENTS_MISSING)
			}
		}
	}
```

## Test in one of the LSP clients

To see your new validation in action, you can rebuild the language server and start one of the editors.
