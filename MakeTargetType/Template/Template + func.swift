//
//  Template + func.swift
//  MakeTargetType
//
//  Created by Gab on 2/3/26.
//

import Foundation

// MARK: caseDefination
extension GenerateTemplate {
    func generateCaseDefinition(APITargetDescriptor model: APITargetDescriptor) -> String {
        if model.caseAssociatedValue.isEmpty {
            return "case \(model.caseName)"
        } else {
            return "case \(model.caseName)(\(model.caseAssociatedValue))"
        }
    }
}

// MARK: caseDefination
extension GenerateTemplate {
    func generateBaseURL(APITargetDescriptor model: APITargetDescriptor) -> String {
        """
        \(generateBaseURLCaseStatement(APITargetDescriptor: model))
        \t\t\t\(generateBaseURLReturn(APITargetDescriptor: model))
        """
    }
    
    private func generateBaseURLCaseStatement(APITargetDescriptor model: APITargetDescriptor) -> String {
        "case .\(model.caseName):"
    }
    
    private func generateBaseURLReturn(APITargetDescriptor model: APITargetDescriptor) -> String {
        "return URL(string: \"\(model.baseUrl)\")!"
    }
}

// MARK: caseDefination
extension GenerateTemplate {
    func generatePath(APITargetDescriptor model: APITargetDescriptor) -> String {
        """
        \(generatePathCaseStatement(APITargetDescriptor: model))
        \t\t\t\(generatePathReturn(APITargetDescriptor: model))
        """
    }
    
    private func generatePathCaseStatement(APITargetDescriptor model: APITargetDescriptor) -> String {
        "case .\(model.caseName):"
    }
    
    private func generatePathReturn(APITargetDescriptor model: APITargetDescriptor) -> String {
        "return \"\(model.path)\""
    }
}

// MARK: caseDefination
extension GenerateTemplate {
    func generateMethod(APITargetDescriptor model: APITargetDescriptor) -> String {
        """
        \(generateMethodCaseStatement(APITargetDescriptor: model))
        \t\t\t\(generateMethodReturn(APITargetDescriptor: model))
        """
    }
    
    private func generateMethodCaseStatement(APITargetDescriptor model: APITargetDescriptor) -> String {
        "case .\(model.caseName):"
    }
    
    private func generateMethodReturn(APITargetDescriptor model: APITargetDescriptor) -> String {
        "return .\(model.httpMethod.id.lowercased())"
    }
}

// MARK: caseDefination
extension GenerateTemplate {
    func generateNetworkTask(APITargetDescriptor model: APITargetDescriptor) -> String {
        """
        \(generateNetworkTaskCaseStatement(APITargetDescriptor: model))
        \t\t\t\(generateNetworkTaskReturn(APITargetDescriptor: model))
        """
    }
    
    private func generateNetworkTaskCaseStatement(APITargetDescriptor model: APITargetDescriptor) -> String {
        switch model.taskKind {
        case .requestPlain:
            "case .\(model.caseName):"
        case .requestParameters:
            model.caseAssociatedValue.isEmpty ? "case .\(model.caseName):"
                                              : "case .\(model.caseName)(let params):"
        }
    }
    
    private func generateNetworkTaskReturn(APITargetDescriptor model: APITargetDescriptor) -> String {
        switch model.taskKind {
        case .requestPlain:
            "return .\(model.taskKind.id)"
        case .requestParameters:
            "return .\(model.taskKind.id)(parameters: params, encoding: \(getEncodingType(APITargetDescriptor: model)))"
        }
    }
    
    private func getEncodingType(APITargetDescriptor model: APITargetDescriptor) -> String {
        switch model.encodingType {
        case .json: "JSONEncoding.default"
        case .url: "URLEncoding.queryString"
        }
    }
}

// MARK: caseDefination
extension GenerateTemplate {
    func generateHeaders(APITargetDescriptor model: APITargetDescriptor) -> String {
        """
        \(generateHeadersCaseStatement(APITargetDescriptor: model))
        \t\t\t\(generateHeadersReturn(APITargetDescriptor: model))
        """
    }
    
    private func generateHeadersCaseStatement(APITargetDescriptor model: APITargetDescriptor) -> String {
        "case .\(model.caseName):"
    }
    
    private func generateHeadersReturn(APITargetDescriptor model: APITargetDescriptor) -> String {
        """
        return [
            \t\t\t\(model.headers.map { "\"\($0.key)\": \"\($0.value)\"" }.joined(separator: ",\n\t\t\t\t"))
        \t\t\t]
        """
    }
}

extension GenerateTemplate {
    func appendTargetTypeCase(fileContent content: inout String, model: APITargetDescriptor) -> String {
        
        insertCaseDefinition(fileContent: &content, APITargetDescriptor: model)
        
        insertBaseURL(fileContent: &content, APITargetDescriptor: model)
        
        insertPath(fileContent: &content, APITargetDescriptor: model)
        
        insertMethod(fileContent: &content, APITargetDescriptor: model)
        
        insertTask(fileContent: &content, APITargetDescriptor: model)
        
        insertHeaders(fileContent: &content, APITargetDescriptor: model)
        
        return content
    }
}

extension GenerateTemplate {
    func insertCaseDefinition(fileContent content: inout String, APITargetDescriptor model: APITargetDescriptor) {
        let caseDef = generateCaseDefinition(APITargetDescriptor: model)
        // Find the last '}' of the enum. Assume enum definition ends before the extension.
        if let enumEndRange = content.range(of: "\n}", options: .backwards, range: content.startIndex..<(content.range(of: "extension")?.lowerBound ?? content.endIndex)) {
            content.insert(contentsOf: "\n\t\(caseDef)", at: enumEndRange.lowerBound)
        }
    }
}

extension GenerateTemplate {
    func insertBaseURL(fileContent content: inout String, APITargetDescriptor model: APITargetDescriptor) {
        guard let propRange = content.range(of: "var baseURL:") else { return }
        guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
        
        var append = generateBaseURL(APITargetDescriptor: model)
        append.insert(contentsOf: "\n\t\t", at: append.endIndex)
        
        if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
            content.insert(contentsOf: append, at: switchEnd.lowerBound)
        }
    }
}

extension GenerateTemplate {
    func insertPath(fileContent content: inout String, APITargetDescriptor model: APITargetDescriptor) {
        guard let propRange = content.range(of: "var path:") else { return }
        guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
        
        var append = generatePath(APITargetDescriptor: model)
        append.insert(contentsOf: "\n\t\t", at: append.endIndex)
        
        if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
            content.insert(contentsOf: append, at: switchEnd.lowerBound)
        }
    }
}

extension GenerateTemplate {
    func insertMethod(fileContent content: inout String, APITargetDescriptor model: APITargetDescriptor) {
        guard let propRange = content.range(of: "var method:") else { return }
        guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
        
        var append = generateMethod(APITargetDescriptor: model)
        append.insert(contentsOf: "\n\t\t", at: append.endIndex)
        
        if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
            content.insert(contentsOf: append, at: switchEnd.lowerBound)
        }
    }
}

extension GenerateTemplate {
    func insertTask(fileContent content: inout String, APITargetDescriptor model: APITargetDescriptor) {
        guard let propRange = content.range(of: "var task:") else { return }
        guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
        
        var append = generateNetworkTask(APITargetDescriptor: model)
        append.insert(contentsOf: "\n\t\t", at: append.endIndex)
        
        if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
            content.insert(contentsOf: append, at: switchEnd.lowerBound)
        }
    }
}

extension GenerateTemplate {
    func insertHeaders(fileContent content: inout String, APITargetDescriptor model: APITargetDescriptor) {
        guard let propRange = content.range(of: "var headers:") else { return }
        guard let switchRange = content.range(of: "switch self {", range: propRange.upperBound..<content.endIndex) else { return }
        
        var append = generateHeaders(APITargetDescriptor: model)
        append.insert(contentsOf: "\n\t\t", at: append.endIndex)
        
        if let switchEnd = content.range(of: "}", range: switchRange.upperBound..<content.endIndex) {
            content.insert(contentsOf: append, at: switchEnd.lowerBound)
        }
    }
}
