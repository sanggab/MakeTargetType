//
//  Model.swift
//  MakeTargetType
//
//  Created by Gab on 1/29/26.
//

import Foundation

struct APITargetDescriptor {
    var caseName: String
    var baseUrl: String
    var path: String
    var httpMethod: HTTPMethod
    var headers: [String: String]
    
    init(
        caseName: String = "",
        baseUrl: String = "",
        path: String = "",
        httpMethod: HTTPMethod = .get,
        headers: [String : String] = [:]
    ) {
        self.caseName = caseName
        self.baseUrl = baseUrl
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
//    mutating func updateCaseName(_ name: String) {
//        self.caseName = name
//    }
//    
//    mutating func updateBaseUrl(_ url: String) {
//        self.baseUrl = url
//    }
//    
//    mutating func updatePath(_ path: String) {
//        self.path = path
//    }
//    
//    mutating func updateHTTPMethod(_ method: String) {
//        let httpMethod = HTTPMethod(rawValue: method)
//        
//        self.httpMethod = httpMethod
//    }
//    
//    mutating func updateHeaders(_ headers: [String: String]) {
//        self.headers = headers
//    }
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
