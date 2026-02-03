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
            "return .\(model.taskKind.id)(parameters: params, encoding: JSONEncoding.default)"
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

