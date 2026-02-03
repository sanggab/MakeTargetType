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
    
    import Alamofire
    
    public enum \(model.displayName)TargetType {
        \(getCaseName(APITargetDescriptor: model))
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
                \(getTaskName(APITargetDescriptor: model))
            }
        }
        
        public var headers: [String : String]? {
            switch self {
            case .\(model.caseName):
                return [
                    \(model.headers.map { "\"\($0.key)\": \"\($0.value)\"" }.joined(separator: ",\n\t\t\t\t"))
                ]
            }
        }
    }
    """
}

func today() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy. MM. dd"
    return formatter.string(from: Date())
}

func thisYear() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: Date())
}

func getCaseName(APITargetDescriptor model: APITargetDescriptor) -> String {
    let caseName: String
    
    switch model.taskKind {
    case .requestPlain:
        caseName = "case \(model.caseName)"
    case .requestParameters:
        caseName = model.caseAssociatedValue.isEmpty ? "case \(model.caseName)"
                                                     : "case \(model.caseName)(\(model.caseAssociatedValue))"
    }
    
    return caseName
}

func getTaskName(APITargetDescriptor model: APITargetDescriptor) -> String {
    let taskName: String
    
    switch model.taskKind {
    case .requestPlain:
        taskName = """
            case .\(model.caseName)
                return .\(model.taskKind.id)
            """
    case .requestParameters:
        let caseName = model.caseAssociatedValue.isEmpty ? "case .\(model.caseName):"
                                                         : "case .\(model.caseName)(let params):"
        
        taskName = """
            \(caseName)
            \(getTaskReturn(APITargetDescriptor: model))
            """
    }
    
    return taskName
}

func getTaskReturn(APITargetDescriptor model: APITargetDescriptor) -> String {
    let taskReturn: String
    
    switch model.taskKind {
    case .requestPlain:
        taskReturn = ".\(model.taskKind.id)"
    case .requestParameters:
        taskReturn = "\t\t\t\treturn .\(model.taskKind.id)(parameters: params, encoding: JSONEncoding.default)"
    }
    
    return taskReturn
}
