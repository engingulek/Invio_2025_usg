//
//  NetworkConstants.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

enum NetworkConstants  {
    static var baseUrl: String {
        return Bundle.main.object(
            forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
}
