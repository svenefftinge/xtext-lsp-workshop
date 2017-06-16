/*
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 */
package org.xtext.calc.scoping

import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.scoping.Scopes
import org.xtext.calc.webCalc.Definition

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 */
class CalculatorScopeProvider extends AbstractCalculatorScopeProvider {
	
	override getScope(EObject context, EReference reference) {
		var scope = super.getScope(context, reference)
		val currentDefinition = EcoreUtil2.getContainerOfType(context, Definition)
		if (currentDefinition !== null && !currentDefinition.params.isEmpty) {
			scope = Scopes.scopeFor(currentDefinition.params, scope)
		}
		return scope
	}
	
}
