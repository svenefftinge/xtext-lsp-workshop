package org.xtext.calc

import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.emf.ecore.EObject
import org.xtext.calc.webCalc.Definition
import org.eclipse.xtext.naming.QualifiedName

class QualifiedNameProvider extends IQualifiedNameProvider.AbstractImpl {
	
	override getFullyQualifiedName(EObject obj) {
		if (obj instanceof Definition) {
			return QualifiedName.create(obj.name) 
		}
		return null
	}
	
}