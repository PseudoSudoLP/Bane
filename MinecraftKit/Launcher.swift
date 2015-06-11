//
//  Launcher.swift
//  Bane
//
//  Created by PseudoSudo on 6/9/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Himotoki

public struct Launcher {
	public struct Version {
		public var name: String
		public var format: Int
	}
	
	public var profiles: [String: Profile]
	public var selectedProfile: String
	public var clientToken: String
	public var authenticationDatabase: [String: User]
	public var selectedUser: String
	public var launcherVersion: Version
}

extension Launcher : Decodable {
	public static func decode(e: Extractor) -> Launcher? {
		let create = {
			Launcher($0)
		}
		
		return build(
			e <|-| "profiles",
			e <| "selectedProfile",
			e <| "clientToken",
			e <|-| "authenticationDatabase",
			e <| "selectedUser",
			e <| "launcherVersion"
		).map(create)
	}
}

extension Launcher.Version : Decodable {
	public static func decode(e: Extractor) -> Launcher.Version? {
		let create = {
			Launcher.Version($0)
		}
		
		return build(
			e <| "name",
			e <| "format"
		).map(create)
	}
}
