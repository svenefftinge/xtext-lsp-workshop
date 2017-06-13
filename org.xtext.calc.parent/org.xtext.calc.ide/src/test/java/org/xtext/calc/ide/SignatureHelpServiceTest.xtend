package org.xtext.calc.ide

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test
import static org.junit.Assert.*

class SignatureHelpServiceTest extends AbstractLanguageServerTest {
	
	new() {
		super("calc")
	}
	
	@Test def void testSignatureHelp() {
		testSignatureHelp [
			column = 7
			line = 2
			it.model = '''
				let myFunc(a,b,c) : 42
				
				myFunc(1, 3, 5)
			'''
			assertSignatureHelp = [ help |
				assertEquals('myFunc(a,b,c)', help.signatures.head.label)
				assertEquals(0, help.activeParameter)
			]
		]
	}
	@Test def void testSignatureHelp_01() {
		testSignatureHelp [
			column = 0
			line = 3
			it.model = '''
				let myFunc(a,b,c) : 42
				
				myFunc(1, 3, 
				5)
			'''
			assertSignatureHelp = [ help |
				assertEquals('myFunc(a,b,c)', help.signatures.head.label)
				assertEquals(2, help.activeParameter)
			]
		]
	}
	
	@Test def void testSignatureHelp_02() {
		testSignatureHelp [
			column = 22
			line = 2
			it.model = '''
				let myFunc(a,b,c) : 42
				
				myFunc(1, 3, myFunc(1,2,4))
			'''
			assertSignatureHelp = [ help |
				assertEquals('myFunc(a,b,c)', help.signatures.head.label)
				assertEquals(1, help.activeParameter)
			]
		]
	}
	
	@Test def void testSignatureHelp_03() {
		testSignatureHelp [
			column = 17
			line = 2
			it.model = '''
				let myFunc(a,b,c) : 42
				
				myFunc(1, 3, myFunc(1,2,4))
			'''
			assertSignatureHelp = [ help |
				assertEquals('myFunc(a,b,c)', help.signatures.head.label)
				assertEquals(2, help.activeParameter)
			]
		]
	}
	
}