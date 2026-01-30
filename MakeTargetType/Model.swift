//
//  Model.swift
//  MakeTargetType
//
//  Created by Gab on 1/29/26.
//

import Foundation

struct HeaderItem: Identifiable, Equatable, Hashable {
    let id: UUID
    var key: String
    var value: String
    
    init(id: UUID = UUID(), key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
}

struct APITargetDescriptor {
    var displayName: String
    var caseName: String
    var baseUrl: String
    var path: String
    var httpMethod: HTTPMethod
    var headers: [HeaderItem]
    
    init(
        displayName: String = "",
        caseName: String = "",
        baseUrl: String = "",
        path: String = "",
        httpMethod: HTTPMethod = .get,
        headers: [HeaderItem] = []
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
    case get = "get"
    /// `POST` method.
    case post = "post"
    /// `CONNECT` method.
    case connect = "connect"
    /// `DELETE` method.
    case delete = "delete"
    /// `HEAD` method.
    case head = "head"
    /// `OPTIONS` method.
    case options = "options"
    /// `PATCH` method.
    case patch = "patch"
    /// `PUT` method.
    case put = "put"
    /// `QUERY` method.
    case query = "query"
    /// `TRACE` method.
    case trace = "trace"
}
