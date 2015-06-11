//
//  Profile.swift
//  Bane
//
//  Created by PseudoSudo on 6/9/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Himotoki

public enum LauncherVisibility : String {
	case Close = "close launcher when game starts"
	case HideAndReopen = "hide launcher and re-open when game closes"
	case KeepOpen = "keep the launcher open"
}

extension LauncherVisibility : Decodable {
	public static func decode(e: Extractor) -> LauncherVisibility? {
		return e.rawValue as? LauncherVisibility
	}
}

public struct Profile {
	public var name: String
	public var gameDirectoryPath: String?
	public var lastVersionID: String?
	public var javaPath: String?
	public var javaArgs: String?
	public var usesHopperCrashService: Bool?
	public var launcherVisibilityOnGameClose: LauncherVisibility?
}

extension Profile : Decodable {
	public static func decode(e: Extractor) -> Profile? {
		let create = {
			Profile($0)
		}
		
		return build(
			e <| "name",
			e <|? "gameDir",
			e <|? "lastVersionId",
			e <|? "javaDir",
			e <|? "javaArgs",
			e <|? "useHopperCrashService",
			e <|? "launcherVisibilityOnGameClose"
		).map(create)
	}
}

extension Profile {
	public static var DefaultGameDirectoryPath: String {
		return "~/Library/Application Support/minecraft".stringByExpandingTildeInPath
	}
	
	public var modsDirectoryPath: String {
		let gameDirectory = gameDirectoryPath ?? Profile.DefaultGameDirectoryPath
		return gameDirectory.stringByAppendingPathComponent("mods")
	}
	
	public var resourcePacksDirectoryPath: String {
		let gameDirectory = gameDirectoryPath ?? Profile.DefaultGameDirectoryPath
		return gameDirectory.stringByAppendingPathComponent("resourcepacks")
	}
	
	public var savesDirectoryPath: String {
		let gameDirectory = gameDirectoryPath ?? Profile.DefaultGameDirectoryPath
		return gameDirectory.stringByAppendingPathComponent("saves")
	}
}
