//
//  MockPageElements.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

@testable import Invio_2025_USG
struct MockPageElements {
    
    static let firstPageElement =  PageElement(currentPage: 1, totalPage: 4, total: 62, itemPerPage: 20, pageSize: 20, data: [
        CityElement(
            city: "İstanbul",
            locations: [
                LocationElement(
                    name: "Galata Kulesi",
                    description: "Tarihi bir kule ve İstanbul'un simgelerinden biri.",
                    coordinates: CoordinatesElement(lat: 41.0256, lng: 28.9744),
                    image: "galata.jpg",
                    id: 1
                ),
                LocationElement(
                    name: "Topkapı Sarayı",
                    description: "Osmanlı İmparatorluğu'nun ana sarayı.",
                    coordinates: CoordinatesElement(lat: 41.0115, lng: 28.9834),
                    image: "topkapi.jpg",
                    id: 2
                )
            ]
        ),
        CityElement(
            city: "Ankara",
            locations: [
                LocationElement(
                    name: "Anıtkabir",
                    description: "Türkiye Cumhuriyeti'nin kurucusu Atatürk'ün anıt mezarı.",
                    coordinates: CoordinatesElement(lat: 39.9251, lng: 32.8369),
                    image: "anitkabir.jpg",
                    id: 3
                ),
                LocationElement(
                    name: "Atakule",
                    description: "Ankara'nın simgelerinden biri olan gözlem kulesi.",
                    coordinates: CoordinatesElement(lat: 39.9036, lng: 32.8597),
                    image: "atakule.jpg",
                    id: 4
                )
            ]
        ),
       
    ])
    
    
    
    static let secondPageElement =  PageElement(currentPage: 2, totalPage: 4, total: 62, itemPerPage: 20, pageSize: 20, data: [
        CityElement(
            city: "Elazığ",
            locations: [
                LocationElement(
                    name: "Harput Kalesi",
                    description: "Elazığ’ın tarihi Harput bölgesinde yer alan kale kalıntıları.",
                    coordinates: CoordinatesElement(lat: 38.6805, lng: 39.227),
                    image: "harputKalesi.jpg",
                    id: 101
                ),
               
            ]
        ),
        CityElement(
            city: "Erzurum",
            locations: [
                LocationElement(
                    name: "Erzurum Kalesi",
                    description: "Şehre hakim, tarihi kale kalıntıları.",
                    coordinates: CoordinatesElement(lat: 39.9005, lng: 41.2705),
                    image: "erzurumkalesi.jpg",
                    id: 106
                ),
            ]
        
        ),
        CityElement(city:"Konumsuz Şehir", locations: [])
    ])
}
