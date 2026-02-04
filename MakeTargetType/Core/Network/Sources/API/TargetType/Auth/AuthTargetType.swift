//
//  AuthTargetType.swift
//  NetworkCore
//
//  Created by FileGeneratorUI on 02/04/2026.
//  Copyright © 2026 Yeoboya. All rights reserved.
//
import Foundation
import Alamofire

public enum AuthTargetType {
    case fetchMessage2([String: Any])
}

extension AuthTargetType: TargetType {
    public var baseURL: URL {
        switch self {
        case .fetchMessage2:
			return URL(string: "https://www.naver.com")!
        }
    }

    public var path: String {
        switch self {
        case .fetchMessage2:
			return "/v1/message"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .fetchMessage2:
			return .post
        }
    }
    
    public var task: NetworkTask {
        switch self {
        case .fetchMessage2(let params):
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .fetchMessage2:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
        }
    }
}
