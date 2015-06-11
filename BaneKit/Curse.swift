//
//  Curse.swift
//  Bane
//
//  Created by PseudoSudo on 6/7/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Foundation

private let ProjectTypeModPackString = "modpacks"
private let ProjectTypeModString = "mc-mods"
private let ProjectTypeTexturePackString = "texture-packs"
private let ProjectTypeWorldString = "worlds"

public enum ProjectType {
	case ModPack(String)
	case Mod(String)
	case TexturePack(String)
	case World(String)
	
	public static func create(stringValue: String, slug: String) -> ProjectType? {
		switch stringValue {
			case ProjectTypeModPackString:
				return .ModPack(slug)
			case ProjectTypeModString:
				return .Mod(slug)
			case ProjectTypeTexturePackString:
				return .TexturePack(slug)
			case ProjectTypeWorldString:
				return .World(slug)
			default:
				return nil
		}
	}
	
	public var category: String {
		switch self {
			case .ModPack(_):
				return ProjectTypeModPackString
			case .Mod(_):
				return ProjectTypeModString
			case .TexturePack(_):
				return ProjectTypeTexturePackString
			case .World(_):
				return ProjectTypeWorldString
		}
	}
	
	public var slug: String {
		switch self {
			case .ModPack(let slug):
				return slug
			case .Mod(let slug):
				return slug
			case .TexturePack(let slug):
				return slug
			case .World(let slug):
				return slug
		}
	}
}

public enum Curse {
	case Home
	case Project(Int)
	case File(ProjectType, Int)
	case Download(ProjectType, Int)
}

extension Curse : MoyaPath {
	public var path: String {
		switch self {
			case .Home:
				return "/"
			case .Project(let projectID):
				// Note that, because of the way that Curse works, it will properly redirect to the right project type.
				return "/mc-mods/\(projectID)"
			case .File(let project, let fileID):
				return "/\(project.category)/\(project.slug)/files/\(fileID)"
			case .Download(let project, let fileID):
				let filePath = Curse.File(project, fileID).path
				return filePath + "/download"
			}
	}
}

extension Curse : MoyaTarget {
	public var baseURL: NSURL {
		return NSURL(string: "http://minecraft.curseforge.com")!
	}
	
	public var method: Moya.Method {
		return .GET
	}
	
	public var parameters: [String: AnyObject] {
		return [:]
	}
	
	public var sampleData: NSData {
		return "".dataUsingEncoding(NSUTF8StringEncoding)!
	}
}
