//
//  Minecraft.swift
//  Bane
//
//  Created by PseudoSudo on 6/7/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Himotoki

public struct Minecraft {
	public var version: String
	public var librariesPath: String
	public var additionalJavaArguments: [String: String]
	public var modLoaders: [ModLoader]
}

extension Minecraft : Decodable {
	public static func decode(e: Extractor) -> Minecraft? {
		let create = {
			Minecraft($0)
		}
		
		return build(
			e <| "version",
			e <| "librariesPath",
			e <|-| "additionalJavaArgs",
			e <|| "modLoaders"
		).map(create)
	}
}
