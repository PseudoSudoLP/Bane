//
//  Manifest.swift
//  Bane
//
//  Created by PseudoSudo on 6/7/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Himotoki
import PromiseKit

public struct Manifest {
	public var name: String
	public var version: String
	public var author: String
	public var description: String
	public var files: [File]
	public var overridesPath: String
	public var minecraft: Minecraft
}

extension Manifest : Decodable {
	public static func decode(e: Extractor) -> Manifest? {
		let create = {
			Manifest($0)
		}
		
		return build(
			e <| "name",
			e <| "version",
			e <| "author",
			e <| "description",
			e <|| "files",
			e <| "overrides",
			e <| "minecraft"
		).map(create)
	}
}

extension Manifest {
	public func install(installationDirectory: NSURL) -> Promise<()> {
		
	}
	
	public func installFiles(installationDirectory: NSURL) -> Promise<()> {
		
	}
}
