//
//  TextTheme.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
enum TextTheme :String {
    case splashTitle
    case errorMessage
    case homeNavTitle
    case count
    case showOnMap
    case favNavTitle
    case favEmptyMessage
    case warning
    case locationAlertMessage
    case yes
    case no
    case getDirection
    case cancel
    case mapType
    case mapQ
    case goDetail
    case ok
    case close
    
    
    var localized : String {
        switch self {
        case .splashTitle:
            return NSLocalizedString("splashTitle",comment: "splashTitle text")
        case .errorMessage:
            return NSLocalizedString("errorMessage",comment: "errorMessage text")
        case .homeNavTitle:
            return NSLocalizedString("homeNavTitle",comment: "homeNavTitle text")
        case .count:
            return NSLocalizedString("count",comment: "count text")
        case .showOnMap:
            return NSLocalizedString("showOnMap",comment: "showOnMap text")
        case .favNavTitle:
            return NSLocalizedString("favNavTitle",comment: "favNavTitle text")
        case .favEmptyMessage:
            return NSLocalizedString("favEmptyMessage",comment: "favEmptyMessage text")
        case .warning:
            return NSLocalizedString("warning",comment: "warning text")
        case .locationAlertMessage:
            return NSLocalizedString("locationAlertMessage",comment: "locationAlertMessage text")
        case .yes:
            return NSLocalizedString("yes",comment: "yes text")
        case .no:
            return NSLocalizedString("no",comment: "no text")
        case .getDirection:
            return NSLocalizedString("getDirection",comment: "getDirection text")
        case .cancel:
            return NSLocalizedString("cancel",comment: "cancel text")
        case .mapType:
            return NSLocalizedString("mapType",comment: "mapType text")
        case .mapQ:
            return NSLocalizedString("mapQ",comment: "mapType text")
        case .goDetail:
            return NSLocalizedString("goDetail",comment: "goDetail text")
        case .ok:
            return NSLocalizedString("ok",comment: "ok text")
        case .close:
            return NSLocalizedString("close",comment: "close text")
        }
    }
}
