//
//  DetailProtocols.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

typealias DetailKits = UIViewAble & SegueAble & NavConUIAble

//MARK: ViewToPresenterDetailProtocol
protocol ViewToPresenterDetailProtocol {
    
    var view : PresenterToViewDetailProtocol? {get}
    func viewDidLoad(rightButtonAction:Selector)
    func getLocationData(_ locatonElement:LocationElement)
    
    func onTappedFavIcon()
    func onTappednShowOnMapButton()
}


//MARK: PresenterToViewDetailProtocol
protocol PresenterToViewDetailProtocol : AnyObject,DetailKits {
    func sendDetailInfo(imageUrl:String?,detail:String)
    func sendErrorMessage(text:String,isHidden:Bool)
}


protocol PresenterToInteractorDetailProtocol {
    func isEntityExist(id:Int16)
    func deleteFav(id:Int16)
    func addToFav(element:LocationElement)
}

protocol InteractorToPresenterDetailProtocol : AnyObject {
    func sendSuccess(state:Bool)
    func sendError()
}

//MARK: PresenterToRouterDetailProtocol
protocol PresenterToRouterDetailProtocol {
    func toLocationMap(view:PresenterToViewDetailProtocol?,locationElement:LocationElement)
}
