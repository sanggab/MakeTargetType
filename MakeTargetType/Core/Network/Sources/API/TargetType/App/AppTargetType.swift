//
//  AppTargetType.swift
//  NetworkCore
//
//  Created by FileGeneratorUI on 2026. 02. 03.
//  Copyright © 2026 Yeoboya. All rights reserved.
//
import Foundation
import Alamofire

public enum AppTargetType {
    case qwe
}

extension AppTargetType: TargetType {
    public var baseURL: URL {
        switch self {
        case .qwe:
            return URL(string: "qweqwe")!
		}
    }

    public var path: String {
        switch self {
        case .qwe:
            return ""
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .qwe:
            return .get
        }
    }
    
    public var task: NetworkTask {
        switch self {
        case .qwe:
    		return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .qwe:
            return [
                "Content-Type": "application/json",
                "Accept-Language": "ko"
            ]
        }
    }
}
