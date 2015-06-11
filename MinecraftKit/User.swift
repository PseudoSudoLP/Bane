//
//  User.swift
//  Bane
//
//  Created by PseudoSudo on 6/9/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Himotoki

public struct User {
	public var username: String
	public var accessToken: String
	public var userID: String
	public var uuid: String
	public var displayName: String
}

extension User : Decodable {
	public static func decode(e: Extractor) -> User? {
		let create = {
			User($0)
		}
		
		return build(
			e <| "username",
			e <| "accessToken",
			e <| "userid",
			e <| "uuid",
			e <| "displayName"
		).map(create)
	}
}
