//
//  ResultData.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

// MARK: - PageElement
struct PageElement: Decodable {
    let currentPage, totalPage, total, itemPerPage: Int
    let pageSize: Int
    let data: [CityElement]
}

// MARK: - CityElement
struct CityElement: Decodable {
    let city: String
    let locations: [LocationElement]
    var isExpend:Bool? = false
}

// MARK: - Location
struct LocationElement: Decodable {
    let name, description: String
    let coordinates: CoordinatesElement
    let image: String?
    let id: Int
}

// MARK: - Coordinates
struct CoordinatesElement: Decodable {
    let lat, lng: Double
}
