//
//  ModLoader.swift
//  Bane
//
//  Created by PseudoSudo on 6/7/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Himotoki

public struct ModLoader {
	public var id: String
	public var primary: Bool
}

extension ModLoader : Decodable {
	static public func decode(e: Extractor) -> ModLoader? {
		let create = {
			ModLoader($0)
		}
		
		return build(
			e <| "id",
			e <| "primary"
		).map(create)
	}
}
