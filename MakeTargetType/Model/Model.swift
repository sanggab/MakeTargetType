//
//  Model.swift
//  MakeTargetType
//
//  Created by Gab on 1/29/26.
//

import Foundation
import Alamofire

public struct HeaderItem: Identifiable, Equatable, Hashable {
    public let id: UUID
    public var key: String
    public var value: String
    
    public init(id: UUID = UUID(), key: String, value: String) {
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

public struct APITargetDescriptor {
    public var displayName: String
    public var caseName: String
    public var caseAssociatedValue: String
    public var baseUrl: String
    public var path: String
    public var httpMethod: HTTPMethod
    public var headers: [HeaderItem]
    public var taskKind: NetworkTaskKind
    
    public init(
        displayName: String = "",
        caseName: String = "",
        caseAssociatedValue: String = "",
        baseUrl: String = "",
        path: String = "",
        httpMethod: HTTPMethod = .get,
        headers: [HeaderItem] = [],
        taskKind: NetworkTaskKind = .requestPlain,
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
    
    public mutating func baseSetting() {
        self.displayName = ""
        self.caseName = ""
        self.caseAssociatedValue = ""
        self.baseUrl = ""
        self.path = ""
        self.httpMethod = .get
        self.headers = [
            HeaderItem(
                key: "Content-Type",
                value: "application/json"
            ),
            HeaderItem(
                key: "Accept-Language",
                value: "ko"
            ),
        ]
        self.taskKind = .requestPlain
    }
}

public enum NetworkTaskKind: String, CaseIterable, Identifiable {
    case requestPlain
//    case requestData
//    case requestJSONEncodable
//    case requestCustomJSONEncodable
    case requestParameters
//    case requestCompositeData
//    case requestCompositeParameters
//    case uploadFile
//    case uploadMultipart
//    case uploadCompositeMultipart
//    case downloadDestination
//    case downloadParameters
    
    public var id: String { rawValue }
}

public extension NetworkTaskKind {
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
    
    public var id: String { rawValue }
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

public struct RequestDataModel {
    var data: Data
}

public struct RequestJSONEncodableModel {
    var encodable: Encodable
}

public struct RequestCustomJSONEncodableModel {
    var encodable: Encodable
    var encoder: JSONEncoder
}

public struct RequestParametersModel {
    var parameters: [String: Any]
    var encoding: ParameterEncoding
}

public struct RequestCompositeDataModel {
    var bodyData: Data
    var urlParameters: [String: Any]
}

public struct RequestCompositeParametersModel {
    var bodyParameters: [String: Any]
    var bodyEncoding: ParameterEncoding
    var urlParameters: [String: Any]
}

public struct UploadFileModel {
    var url: URL
}

public struct UploadMultipartModel {
    var multipartFormData: [MultipartFormData]
}

public struct UploadCompositeMultipartModel {
    var multipartFormData: [MultipartFormData]
    var urlParameters: [String: Any]
}

public struct DownloadDestinationModel {
    var destination: DownloadRequest.Destination
}

public struct DownloadParametersModel {
    var parameters: [String: Any]
    var encoding: ParameterEncoding
    var destination: DownloadRequest.Destination
}

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: NetworkTask { get }
    var headers: [String: String]? { get }
}
