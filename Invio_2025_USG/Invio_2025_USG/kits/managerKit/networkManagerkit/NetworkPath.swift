//
//  NetworkPath.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

//MARK: - NetworkPath
enum NetworkPath {
    case page(Int)
}

extension NetworkPath : TargetType {
    var baseURL: String {
        return NetworkConstants.baseUrl
    }
    
    var path: String {
        switch self {
        case .page(let pageNumber):
            return "\(pageNumber).json"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .page:
            return .GET
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .page:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
