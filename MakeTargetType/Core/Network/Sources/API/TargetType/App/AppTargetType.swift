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
    case fetchMember([String: Any])
    case fetchMessage([String: Any])
    case fetchMessage2([String: Any])
	case asdasds
	case qweqweqwe
	case aasda
    case dddd([String: Any])
}

extension AppTargetType: TargetType {
    public var baseURL: URL {
        switch self {
        case .sdsd:
            return URL(string: "asdssd")!
		case .aadad:
			return URL(string: "qweqeq")!
		case .fetchMember:
			return URL(string: "https://www.naver.com")!
		case .fetchMessage:
			return URL(string: "https://www.naver.com")!
		case .fetchMessage2:
			return URL(string: "https://www.naver.com")!
		case .asdasds:
			return URL(string: "qe")!
		case .qweqweqwe:
			return URL(string: "")!
		case .aasda:
			return URL(string: "")!
		case .dddd:
			return URL(string: "ddd")!
		}
    }

    public var path: String {
        switch self {
        case .sdsd:
			return ""
		case .aadad:
			return ""
		case .fetchMember:
			return "/v1/members"
		case .fetchMessage:
			return "/v1/message"
		case .fetchMessage2:
			return "/v1/message"
		case .asdasds:
			return "dasda"
		case .qweqweqwe:
			return ""
		case .aasda:
			return ""
		case .dddd:
			return "dd"
		}
    }

    public var method: HTTPMethod {
        switch self {
        case .sdsd:
			return .get
        case .aadad:
			return .get
		case .fetchMember:
			return .post
		case .fetchMessage:
			return .post
		case .fetchMessage2:
			return .post
		case .asdasds:
			return .get
		case .qweqweqwe:
			return .get
		case .aasda:
			return .get
		case .dddd:
			return .get
		}
    }
    
    public var task: NetworkTask {
        switch self {
        case .sdsd:
			return .requestPlain
        case .aadad:
			return .requestPlain
		case .fetchMember(let params):
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		case .fetchMessage(let params):
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		case .fetchMessage2(let params):
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		case .asdasds:
			return .requestPlain
		case .qweqweqwe:
			return .requestPlain
		case .aasda:
			return .requestPlain
		case .dddd:
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
		case .fetchMember:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
		case .fetchMessage:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
		case .fetchMessage2:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
		case .asdasds:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko",
				"qwe": "qweqwe"
			]
		case .qweqweqwe:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
		case .aasda:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko",
				"r": "werewr"
			]
		case .dddd:
			return [
    			"Content-Type": "application/json",
				"Accept-Language": "ko"
			]
		}
    }
}
