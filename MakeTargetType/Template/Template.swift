//
//  Template.swift
//  MakeTargetType
//
//  Created by Gab on 1/28/26.
//

import Foundation

class GenerateTemplate {
    static let `default` = GenerateTemplate()
    
    func makeTargetTypeDefault(APITargetDescriptor model: APITargetDescriptor) -> String {
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
            \(generateCaseDefinition(APITargetDescriptor: model))
        }
        
        extension \(model.displayName)TargetType: TargetType {
            public var baseURL: URL {
                switch self {
                \(generateBaseURL(APITargetDescriptor: model))
                }
            }
        
            public var path: String {
                switch self {
                \(generatePath(APITargetDescriptor: model))
                }
            }
        
            public var method: HTTPMethod {
                switch self {
                \(generateMethod(APITargetDescriptor: model))
                }
            }
            
            public var task: NetworkTask {
                switch self {
                \(generateNetworkTask(APITargetDescriptor: model))
                }
            }
            
            public var headers: [String : String]? {
                switch self {
                \(generateHeaders(APITargetDescriptor: model))
                }
            }
        }
        """
    }
}
