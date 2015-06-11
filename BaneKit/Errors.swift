//
//  Errors.swift
//  Bane
//
//  Created by PseudoSudo on 6/10/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Foundation

public let BaneKitErrorDomain = "com.pseudosudo.BaneKit.ErrorDomain"

public enum BaneKitError {
	case NoProjectType
	case UnknownProjectType(String)
}

extension BaneKitError : Printable {
	public var description: String {
		switch self {
			case .NoProjectType:
				return "Could not determine the project type."
			case .UnknownProjectType(let projectType):
				return "Unknown project type '\(projectType)'"
		}
	}
}

extension BaneKitError {
	public var error: NSError {
		return NSError(domain: BaneKitErrorDomain, code: 0, userInfo: [
			NSLocalizedDescriptionKey: self.description
		])
	}
}
