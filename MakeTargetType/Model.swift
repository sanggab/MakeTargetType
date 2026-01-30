//
//  Model.swift
//  MakeTargetType
//
//  Created by Gab on 1/29/26.
//

import Foundation

struct APITargetDescriptor {
    var displayName: String
    var caseName: String
    var baseUrl: String
    var path: String
    var httpMethod: HTTPMethod
    var headers: [String: String]
    
    init(
        displayName: String = "",
        caseName: String = "",
        baseUrl: String = "",
        path: String = "",
        httpMethod: HTTPMethod = .get,
        headers: [String : String] = [:]
    ) {
        self.displayName = displayName
        self.caseName = caseName
        self.baseUrl = baseUrl
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
    }
}

public enum HTTPMethod: String, CaseIterable, Sendable {
    /// `GET` method.
    case get = "GET"
    /// `POST` method.
    case post = "POST"
    /// `CONNECT` method.
    case connect = "CONNECT"
    /// `DELETE` method.
    case delete = "DELETE"
    /// `HEAD` method.
    case head = "HEAD"
    /// `OPTIONS` method.
    case options = "OPTIONS"
    /// `PATCH` method.
    case patch = "PATCH"
    /// `PUT` method.
    case put = "PUT"
    /// `QUERY` method.
    case query = "QUERY"
    /// `TRACE` method.
    case trace = "TRACE"
}


//public struct HTTPMethod: RawRepresentable, Equatable, Hashable, Sendable, CaseIterable {
//    /// `CONNECT` method.
//    public static let connect = HTTPMethod(rawValue: "CONNECT")
//    /// `DELETE` method.
//    public static let delete = HTTPMethod(rawValue: "DELETE")
//    /// `GET` method.
//    public static let get = HTTPMethod(rawValue: "GET")
//    /// `HEAD` method.
//    public static let head = HTTPMethod(rawValue: "HEAD")
//    /// `OPTIONS` method.
//    public static let options = HTTPMethod(rawValue: "OPTIONS")
//    /// `PATCH` method.
//    public static let patch = HTTPMethod(rawValue: "PATCH")
//    /// `POST` method.
//    public static let post = HTTPMethod(rawValue: "POST")
//    /// `PUT` method.
//    public static let put = HTTPMethod(rawValue: "PUT")
//    /// `QUERY` method.
//    public static let query = HTTPMethod(rawValue: "QUERY")
//    /// `TRACE` method.
//    public static let trace = HTTPMethod(rawValue: "TRACE")
//
//    public let rawValue: String
//
//    public init(rawValue: String) {
//        self.rawValue = rawValue
//    }
//}
