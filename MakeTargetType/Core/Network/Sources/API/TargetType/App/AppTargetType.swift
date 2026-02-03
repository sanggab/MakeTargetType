//
//  AppTargetType.swift
//  NetworkCore
//
//  Created by FileGeneratorUI on 02/03/2026.
//  Copyright © 2026 Yeoboya. All rights reserved.
//
import Foundation
import Alamofire

public enum AppTargetType {
    case sdfdsf(sdfsdf)
}

extension AppTargetType: TargetType {
    public var baseURL: URL {
        switch self {
        case .sdfdsf:
			return URL(string: "e")!
        }
    }

    public var path: String {
        switch self {
        case .sdfdsf:
			return "qweq"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .sdfdsf:
			return .post
        }
    }
    
    public var task: NetworkTask {
        switch self {
        case .sdfdsf(let params):
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .sdfdsf:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
        }
    }
}