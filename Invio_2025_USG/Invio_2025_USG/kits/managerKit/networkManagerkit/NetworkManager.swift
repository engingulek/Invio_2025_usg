//
//  NetworkManager.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import Alamofire
//MARK: - NetworkError
enum NetworkError : Error {
    case invalidResponse
    case valueError
    case badRequest
    case notFound
    case unexpectedError
}

//MARK: - NetworkManagerProtocol
 protocol NetworkManagerProtocol {
    func fetch<T:Decodable>(
        target:NetworkPath,
        responseClass:T.Type) async throws -> T
}

//MARK: - NetworkManager : NetworkManagerProtocol
 class NetworkManager : NetworkManagerProtocol {
     init() {}
    /// Fetch for NetworkManager
      /// - Parameters:
      ///   - target: request types
      ///   - responseClass: The type of data that will be received in response to the request
      func fetch<T>(target: NetworkPath, responseClass: T.Type) async throws -> T where T : Decodable {
          let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
          let url = target.baseURL + target.path
          let parameters = buildParams(requestType: target.requestType)
          let request = AF.request(
              url,
              method: method,
              parameters: parameters.0,
              encoding: parameters.1
          )
              .validate()
              .serializingDecodable(T.self)
        
          let result = await request.response
          
          guard let response = result.response else {
              throw NetworkError.invalidResponse
          }
          
          switch response.statusCode {
          case 200...299:
              guard let value = result.value else {
                  throw NetworkError.valueError
              }
              return value
          case 400:
              throw NetworkError.badRequest
          case 404:
              throw NetworkError.notFound
          default:
              throw NetworkError.unexpectedError
          }
      }
      
      private func buildParams(requestType: RequestType) -> ([String: Any], ParameterEncoding) {
          switch requestType {
          case .requestPlain:
              return ([:], URLEncoding.default)
          }
      }
}
