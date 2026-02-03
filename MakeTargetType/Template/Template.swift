//
//  Template.swift
//  MakeTargetType
//
//  Created by Gab on 1/28/26.
//

import Foundation

func makeTargetTypeDefault(displayName: String) -> String {
    return ""
}

func makeTargetTypeDefault(APITargetDescriptor model: APITargetDescriptor) -> String {
    let taskCode = getTaskName(APITargetDescriptor: model)
    let caseDefinition = getCaseDefinition(model: model)
    
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
        \(caseDefinition)
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
    \(model.headers.map { "                \"\($0.key)\": \"\($0.value)\"" }.joined(separator: ",\n"))
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

func appendTargetTypeCase(fileContent: String, model: APITargetDescriptor) -> String {
    var content = fileContent
    let caseName = model.caseName
    
    // 1. Add Case Definition to Enum
    let caseDef = getCaseDefinition(model: model)
    // Find the last '}' of the enum. Assume enum definition ends before the extension.
    if let enumEndRange = content.range(of: "}", options: .backwards, range: content.startIndex..<(content.range(of: "extension")?.lowerBound ?? content.endIndex)) {
        content.insert(contentsOf: "\n    \(caseDef)", at: enumEndRange.lowerBound)
    }
    
    // Helper to insert case into switch
    func insertIntoSwitch(property: String, code: String) {
        // Find 'var property: Type {'
        // Then find 'switch self {' inside it.
        // Then find the closing '}' of the switch.
        // We look for the pattern: var property: .*? \{.*?switch self \{
        
        // Simple heuristic: Find 'var property:' -> Find 'switch self {' -> Find next '}' (which closes switch)
        // Be careful with nested braces. But properties here are simple.
        
        guard let propRange = content.range(of: "var \(property):") else { return }
        guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
        
        // Find closing brace of switch. It should be the first '}' after switch start,
        // assuming no nested blocks inside case bodies (NetworkTask might have, but headers usually don't).
        // Actually NetworkTask cases might have parens but not braces usually in this template.
        // Safer: Find '}' at same indentation level or simply the next '}' if we assume standard formatting.
        // Let's assume standard formatting where '}' closing switch is on a new line with 8 or 12 spaces.
        // Or just find the next '}' that isn't part of a string literal.
        
        // Let's use a simple scanner for balancing braces if needed, but for now searching for "        }" (8 spaces) is likely robust for this template.
        // Or just search for the next "}" and hope.
        // Let's try to find the next "}" that follows the last case or default.
        
        if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
             content.insert(contentsOf: "\n            \(code)", at: switchEnd.lowerBound)
        }
    }
    
    // 2. baseURL
    insertIntoSwitch(property: "baseURL", code: "case .\(caseName):\n                return URL(string: \"\(model.baseUrl)\")!")
    
    // 3. path
    insertIntoSwitch(property: "path", code: "case .\(caseName):\n                return \"\(model.path)\"")
    
    // 4. method
    insertIntoSwitch(property: "method", code: "case .\(caseName):\n                return .\(model.httpMethod.rawValue.lowercased())")
    
    // 5. task
    let taskCode = getTaskName(APITargetDescriptor: model)
    insertIntoSwitch(property: "task", code: "case .\(caseName):\n                return \(taskCode)")
    
    // 6. headers
    let headersCode = """
case .\(caseName):
                return [
\(model.headers.map { "                \"\($0.key)\": \"\($0.value)\"" }.joined(separator: ",\n"))
                ]
"""
    insertIntoSwitch(property: "headers", code: headersCode)
    
    return content
}

// Helpers to avoid code duplication

func getCaseDefinition(model: APITargetDescriptor) -> String {
    if model.caseAssociatedValue.isEmpty {
        return "case \(model.caseName)"
    } else {
        return "case \(model.caseName)(\(model.caseAssociatedValue))"
    }
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
        taskReturn = "return .\(model.taskKind.id)(parameters: params, encoding: JSONEncoding.default)"
    }
    
    return taskReturn
}
