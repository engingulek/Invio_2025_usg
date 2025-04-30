//
//  MapEnumTypes.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

enum AnnotationtType {
    case star
    case pin
}

struct AnnotationCoordinate {
    let latitude:Double
    let longitude:Double
    let meters:Double
    let type:AnnotationtType
}

enum MapType {
    case appleMap
    case yandexMap
}
