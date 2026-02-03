//
//  Template.swift
//  MakeTargetType
//
//  Created by Gab on 1/28/26.
//

import Foundation

class GenerateTemplate {
    static let `default` = GenerateTemplate()
    
    func makeTargetTypeDefault(APITargetDescriptor model: APITargetDescriptor) -> String {
        return """
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
            \(generateCaseDefinition(APITargetDescriptor: model))
        }
        
        extension \(model.displayName)TargetType: TargetType {
            public var baseURL: URL {
                switch self {
                \(generateBaseURL(APITargetDescriptor: model))
                }
            }
        
            public var path: String {
                switch self {
                \(generatePath(APITargetDescriptor: model))
                }
            }
        
            public var method: HTTPMethod {
                switch self {
                \(generateMethod(APITargetDescriptor: model))
                }
            }
            
            public var task: NetworkTask {
                switch self {
                \(generateNetworkTask(APITargetDescriptor: model))
                }
            }
            
            public var headers: [String : String]? {
                switch self {
                \(generateHeaders(APITargetDescriptor: model))
                }
            }
        }
        """
    }
}

func appendTargetTypeCase(fileContent: String, model: APITargetDescriptor) -> String {
    return ""
//    var content = fileContent
//    
//    // 1. Add Case Definition to Enum
//    let caseDef = getCaseDefinition(model: model)
//    // Find the last '}' of the enum. Assume enum definition ends before the extension.
//    if let enumEndRange = content.range(of: "\n}", options: .backwards, range: content.startIndex..<(content.range(of: "extension")?.lowerBound ?? content.endIndex)) {
//        content.insert(contentsOf: "\n\t\(caseDef)", at: enumEndRange.lowerBound)
//    }
//    
//    insertBaseURL(APITargetDescriptor: model, fileContent: &content)
//    
//    inserPath(APITargetDescriptor: model, fileContent: &content)
//
//    return content
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
            case .\(model.caseName):
                \(getTaskReturn(APITargetDescriptor: model))
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
        taskReturn = "\t\treturn .\(model.taskKind.id)"
    case .requestParameters:
        taskReturn = "return .\(model.taskKind.id)(parameters: params, encoding: JSONEncoding.default)"
    }
    
    return taskReturn
}

func insertBaseURL(APITargetDescriptor model: APITargetDescriptor, fileContent content: inout String) {
    guard let propRange = content.range(of: "var baseURL:") else { return }
    guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
    
    let append = """
        case .\(model.caseName):
            \t\treturn URL(string: "\(model.baseUrl)")!\n\t\t
        """
    
    print("상갑 logEvent \(#function) propRange \(propRange)")
    print("상갑 logEvent \(#function) switchRange \(switchRange)")
    
    if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
        content.insert(contentsOf: append, at: switchEnd.lowerBound)
    }
}

func inserPath(APITargetDescriptor model: APITargetDescriptor, fileContent content: inout String) {
    guard let propRange = content.range(of: "var path:") else { return }
    guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
    
    let append = """
        case .\(model.caseName):
            \t\treturn "\(model.path)"\n\t\t
        """
    
    print("상갑 logEvent \(#function) propRange \(propRange)")
    print("상갑 logEvent \(#function) switchRange \(switchRange)")
    
    if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
        content.insert(contentsOf: append, at: switchEnd.lowerBound)
    }
}
