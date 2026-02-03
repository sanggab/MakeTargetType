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

public enum ParameterEncodingType: String, CaseIterable, Identifiable {
    case url = "URLEncoding.default"
    case json = "JSONEncoding.default"
    
    public var id: String { rawValue }
}

struct APITargetDescriptor {
    var displayName: String
    var caseName: String
    var caseAssociatedValue: String
    var baseUrl: String
    var path: String
    var httpMethod: HTTPMethod
    var headers: [HeaderItem]
    var taskKind: NetworkTaskKind
    var parameters: [HeaderItem] = []
    
    init(
        displayName: String = "",
        caseName: String = "",
        caseAssociatedValue: String = "",
        baseUrl: String = "",
        path: String = "",
        httpMethod: HTTPMethod = .get,
        headers: [HeaderItem] = [],
        taskKind: NetworkTaskKind = .requestPlain,
        parameters: [HeaderItem] = []
    ) {
        self.displayName = displayName
        self.caseName = caseName
        self.caseAssociatedValue = caseAssociatedValue
        self.baseUrl = baseUrl
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
        self.taskKind = taskKind
    }
}

public enum NetworkTaskKind: String, CaseIterable, Identifiable {
    case requestPlain
//    case requestData
    case requestParameters
//    case requestJSONEncodable
//    case requestCustomJSONEncodable
//    case requestCompositeData
//    case requestCompositeParameters
//    case uploadFile
//    case uploadMultipart
//    case uploadCompositeMultipart
//    case downloadDestination
//    case downloadParameters
    
    public var id: String { rawValue }
}

extension NetworkTaskKind {
    var placeHolder: [String] {
        switch self {
        case .requestPlain:
            return []
//        case .requestData:
//            return ["Data"]
//        case .requestJSONEncodable:
//            return ["Encodable"]
//        case .requestCustomJSONEncodable:
//            return ["Encodable", "encoder: JSONEncoder"]
        case .requestParameters:
            return ["parameters: [String: Any]", "encoding: ParameterEncoding"]
//        case .requestCompositeData:
//            return ["bodyData: Data", "urlParameters: [String: Any]"]
//        case .requestCompositeParameters:
//            return ["bodyParameters: [String: Any]", "bodyEncoding: ParameterEncoding", "urlParameters: [String: Any]"]
//        case .uploadFile:
//            return ["URL"]
//        case .uploadMultipart:
//            return ["[MultipartFormData]"]
//        case .uploadCompositeMultipart:
//            return ["[MultipartFormData]", "urlParameters: [String: Any]"]
//        case .downloadDestination:
//            return ["Alamofire.DownloadRequest.Destination"]
//        case .downloadParameters:
//            return ["parameters: [String: Any]", "encoding: ParameterEncoding", "destination: Alamofire.DownloadRequest.Destination"]
        }
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

struct RequestDataModel {
    var data: Data
}

struct RequestJSONEncodableModel {
    var encodable: Encodable
}

struct RequestCustomJSONEncodableModel {
    var encodable: Encodable
    var encoder: JSONEncoder
}

struct RequestParametersModel {
    var parameters: [String: Any]
    var encoding: ParameterEncoding
}

struct RequestCompositeDataModel {
    var bodyData: Data
    var urlParameters: [String: Any]
}

struct RequestCompositeParametersModel {
    var bodyParameters: [String: Any]
    var bodyEncoding: ParameterEncoding
    var urlParameters: [String: Any]
}

struct UploadFileModel {
    var url: URL
}

struct UploadMultipartModel {
    var multipartFormData: [MultipartFormData]
}

struct UploadCompositeMultipartModel {
    var multipartFormData: [MultipartFormData]
    var urlParameters: [String: Any]
}

struct DownloadDestinationModel {
    var destination: DownloadRequest.Destination
}

struct DownloadParametersModel {
    var parameters: [String: Any]
    var encoding: ParameterEncoding
    var destination: DownloadRequest.Destination
}
