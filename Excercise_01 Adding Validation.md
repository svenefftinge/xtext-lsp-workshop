# Excercise: Validate Function Calls

At this point you should have the projects checked out and should have been able to start one of the available editors to try the _Calculator DSL_. Here comes the first real excercise :) 
Our language allows to call symbols defined elsewhere. Those definitions may define parameters. We need to validate any defintion refreence to provide the correct number of arguments.

## Solution : Implement a Validation Rule

The Xtetx generator already provided us with a stub, to put in validation rules. To check any feature calls we can put the following code in place:

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

It's a good idea to develop such enhancements in a test-driven way. Xtext provides good test utilities for most of these enhancements. 
IF you are not sure how to do it yourself, please have a look at [the test for the validation method](org.xtext.calc.parent/org.xtext.calc/src/test/java/org/xtext/calc/tests/ValidationTest.xtend).

## Test in one of the LSP clients

To see your new validation in action, you can rebuild the language server and start one of the editors.