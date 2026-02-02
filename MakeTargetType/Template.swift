//
//  Template.swift
//  MakeTargetType
//
//  Created by Gab on 1/28/26.
//

import Foundation

func makeTargetTypeDefault(APITargetDescriptor model: APITargetDescriptor) -> String {
    """
    //
    //  \(model.displayName)TargetType.swift
    //  NetworkCore
    //
    //  Created by FileGeneratorUI on \(today()).
    //  Copyright © \(thisYear()) Yeoboya. All rights reserved.
    //
    import Foundation
    
    public enum \(model.displayName)TargetType {
        case \(model.caseName)
    }
    
    extension \(model.displayName)TargetType: TargetType {
        public var baseURL: URL {
            switch self {
            case .\(model.caseName):
                return URL(string: "\(model.baseUrl)")!
            }
        }
    
        public var path: String {
            switch self {
            case .\(model.caseName):
                return "\(model.path)"
            }
        }
    
        public var method: HTTPMethod {
            switch self {
            case .\(model.caseName):
                return .\(model.httpMethod.rawValue.lowercased())
            }
        }
        
        public var task: NetworkTask {
            switch self {
            case .\(model.caseName):
                return .
            }
        }
        
        public var headers: [String : String]? {
            switch self {
            case .\(model.caseName):
                return [
                    \(model.headers.map { "\"\($0.key)\": \"\($0.value)\"" }.joined(separator: ",\n\t\t\t\t\t"))
                ]
            }
        }
    }
    """
}
