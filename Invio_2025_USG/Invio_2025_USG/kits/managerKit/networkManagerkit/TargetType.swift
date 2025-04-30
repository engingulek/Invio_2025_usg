//
//  TargetType.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: String {get}
    var path: String {get}
    var method: AlamofireMethod {get}
    var requestType: RequestType {get}
    var headers: [String: String]? {get}
}

enum AlamofireMethod: String {
    case GET
}

enum RequestType {
    case requestPlain
}
