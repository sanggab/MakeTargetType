//
//  Template.swift
//  MakeTargetType
//
//  Created by Gab on 1/28/26.
//

import Foundation

func makeTargetTypeDefault(A: String) -> String {
    """
    //
    //  \(A)TargetType.swift
    //  NetworkCore
    //
    //  Created by FileGeneratorUI on \(today()).
    //  Copyright © \(thisYear()) Yeoboya. All rights reserved.
    //
    import Foundation
    
    public enum \(A)TargetType {
        case test
    }
    
    public extension \(A)TargetType: TargetType {
        var baseURL: URL {
            switch self {
            case .test:
                return URL(string: "")!
            }
        }
    
        var path: String {
            switch self {
            case .uploadPhoto:
                return ""
            }
        }
    
        var method: HTTPMethod {
            switch self {
            case .test:
                return .get
            }
        }
        
        var task: NetworkTask {
            switch self {
            case .test:
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            switch self {
            case .test:
                return [
                    "Content-Type": "application/json",
                    "Accept-Language": "ko"
                ]
            }
        }
    }
    """
}

func makeTargetType() -> String {
    return ""
}
