//
//  File.swift
//  Bane
//
//  Created by PseudoSudo on 6/7/15.
//  Copyright (c) 2015 PseudoSudo. All rights reserved.
//

import Foundation
import Himotoki
import PromiseKit
import Alamofire

public struct File {
	public var projectID: Int
	public var fileID: Int
	public var required: Bool
}

extension File : Decodable {
	public static func decode(e: Extractor) -> File? {
		let create = {
			File($0)
		}
		
		return build(
			e <| "projectID",
			e <| "fileID",
			e <| "required"
		).map(create)
	}
}

extension File {
	public func install(targetDirectory: NSURL, provider: MoyaProvider<Curse>) -> Promise<()> {
		return getProjectType(provider).then { (project: ProjectType) -> Promise<()> in
			return self.downloadMod(project, targetDirectory: targetDirectory, provider: provider)
		}
	}
	
	private func getProjectType(provider: MoyaProvider<Curse>) -> Promise<ProjectType> {
		return Promise { fulfill, reject in
			provider.request(.Project(projectID), completion: { data, statusCode, response, error in
				if let pathComponents = response?.URL?.pathComponents {
					if count(pathComponents) < 2 {
						reject(BaneKitError.NoProjectType.error)
					}
					else {
						let slug = pathComponents[pathComponents.endIndex] as! String
						let category = pathComponents[pathComponents.endIndex - 1] as! String
						
						if let projectType = ProjectType.create(category, slug: slug) {
							fulfill(projectType)
						}
						else {
							reject(BaneKitError.UnknownProjectType(category).error)
						}
					}
				}
				else {
					reject(error!)
				}
			})
		}
	}
	
	public func downloadMod(project: ProjectType, targetDirectory: NSURL, provider: MoyaProvider<Curse>) -> Promise<()> {
		return Promise { fulfill, reject in
			let endpoint = provider.endpoint(.Download(project, fileID))
			let URLRequest = endpoint.urlRequest
			
			Alamofire.Manager.sharedInstance.download(URLRequest, destination: { (URL, response) -> NSURL in
				return targetDirectory.URLByAppendingPathComponent(response.suggestedFilename!)
			}).response { (URLRequestConvertible, response, data, error) -> Void in
				if let error = error {
					reject(error)
				}
				else {
					fulfill()
				}
			}
		}
	}
}
