////
////  AppTargetType.swift
////  NetworkCore
////
////  Created by FileGeneratorUI on 02/02/2026.
////  Copyright © 2026 Yeoboya. All rights reserved.
////
//import Foundation
//
//public enum AppTargetType {
//    case hi
//}
//
//extension AppTargetType: TargetType {
//    public var baseURL: URL {
//        switch self {
//        case .hi:
//            return URL(string: "bye")!
//        }
//    }
//
//    public var path: String {
//        switch self {
//        case .hi:
//            return "ohoo"
//        }
//    }
//
//    public var method: HTTPMethod {
//        switch self {
//        case .hi:
//            return .post
//        }
//    }
//    
//    public var task: NetworkTask {
//        switch self {
//        case .hi:
//            return .
//        }
//    }
//    
//    public var headers: [String : String]? {
//        switch self {
//        case .hi:
//            return [
//                "Content-Type": "application/json",
//				"Accept-Language": "ko"
//            ]
//        }
//    }
//}
