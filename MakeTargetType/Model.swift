//
//  Model.swift
//  MakeTargetType
//
//  Created by Gab on 1/29/26.
//

import Foundation
import Alamofire

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

/// Represents an HTTP task.
public enum NetworkTask {

    /// A request with no additional data.
    case requestPlain

    /// A requests body set with data.
    case requestData(Data)

    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)

    /// A request body set with `Encodable` type and custom encoder
    case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)

    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)

    /// A requests body set with data, combined with url parameters.
    case requestCompositeData(bodyData: Data, urlParameters: [String: Any])

    /// A requests body set with encoded parameters combined with url parameters.
    case requestCompositeParameters(bodyParameters: [String: Any], bodyEncoding: ParameterEncoding, urlParameters: [String: Any])

    /// A file upload task.
    case uploadFile(URL)

    /// A "multipart/form-data" upload task.
    case uploadMultipart([MultipartFormData])

    /// A "multipart/form-data" upload task  combined with url parameters.
    case uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any])

    /// A file download task to a destination.
    case downloadDestination(Alamofire.DownloadRequest.Destination)

    /// A file download task to a destination with extra parameters using the given encoding.
    case downloadParameters(parameters: [String: Any], encoding: ParameterEncoding, destination: Alamofire.DownloadRequest.Destination)
}
