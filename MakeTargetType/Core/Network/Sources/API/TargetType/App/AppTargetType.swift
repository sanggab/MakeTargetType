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
    case sdsd
	case aadad
}

extension AppTargetType: TargetType {
    public var baseURL: URL {
        switch self {
        case .sdsd:
            return URL(string: "asdssd")!
		case .aadad:
			return URL(string: "qweqeq")!
		}
    }

    public var path: String {
        switch self {
        case .sdsd:
			return ""
		case .aadad:
			return ""
		}
    }

    public var method: HTTPMethod {
        switch self {
        case .sdsd:
			return .get
        case .aadad:
			return .get
		}
    }
    
    public var task: NetworkTask {
        switch self {
        case .sdsd:
			return .requestPlain
        case .aadad:
			return .requestPlain
		}
    }
    
    public var headers: [String : String]? {
        switch self {
        case .sdsd:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
        case .aadad:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
		}
    }
}
