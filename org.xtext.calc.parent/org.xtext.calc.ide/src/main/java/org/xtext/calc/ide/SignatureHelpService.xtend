/**
 * Copyright (c) 2017 TypeFox GmbH (http://typefox.io)
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
 
package org.xtext.calc.ide

import com.google.inject.Singleton
import org.eclipse.lsp4j.ParameterInformation
import org.eclipse.lsp4j.SignatureHelp
import org.eclipse.lsp4j.SignatureInformation
import org.eclipse.xtext.ide.server.signatureHelp.ISignatureHelpService
import org.eclipse.xtext.nodemodel.util.NodeModelUtils
import org.eclipse.xtext.resource.XtextResource
import org.xtext.calc.webCalc.Definition
import org.xtext.calc.webCalc.FeatureCall

import static extension org.eclipse.xtext.nodemodel.util.NodeModelUtils.getNode

/**
 * Implements signature help for the feature calls in the calculator DSL.
 */
@Singleton class SignatureHelpService implements ISignatureHelpService {
	
	override SignatureHelp getSignatureHelp(XtextResource resource, int offset) {
		val nodesBeforeOffset = resource.parseResult.rootNode.leafNodes.takeWhile[it.offset<offset];
		val lastOpening = nodesBeforeOffset.findLast[text=='(']
		val lastClosing = nodesBeforeOffset.findLast[text==')']
		if (lastOpening === null) {
			return EMPTY
		}
		if (lastClosing !== null && lastOpening.offset < lastClosing.offset) {
			return EMPTY
		}
		switch element : NodeModelUtils.findActualSemanticObjectFor(lastOpening) {
			FeatureCall case element.feature instanceof Definition : 				
				return getSignatureHelp(element, element.feature as Definition, offset)
			default : 
				return EMPTY
		}
	}

	private def SignatureHelp getSignatureHelp(FeatureCall featureCall, Definition definition, int offset) {
		var activeParameter = 0
		for (node : featureCall.node.children) {
			if (node.text == '(' && node.offset >= offset) {
				return EMPTY
			} else if (node.text == ')' && node.offset < offset) {
				return EMPTY
			} else if (node.text == ',') {
				if (node.offset < offset) {
					activeParameter++
				}
			}
		}
		val parameters = definition.params.map [
			new ParameterInformation(name, null)
		]
		return new SignatureHelp(#[
				new SignatureInformation(
					'''«definition.name»(«definition.params.map[name].join(',')»)'''
					, null
					, parameters)
			], 0, activeParameter)
	}
	
}
