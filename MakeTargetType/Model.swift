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
