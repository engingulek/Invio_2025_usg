//
//  FavoritesProtocols.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

typealias FavKits = UIViewAble & SegueAble & NavConUIAble

//MARK: TableViewFavoritesProtocol
protocol TableViewFavoritesProtocol {
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func cellForItem(at indexPath:IndexPath) -> String
    func didSelectRow(at indexPath:IndexPath)
    func onTappedFavIcon(indexPath: IndexPath)
}

//MARK: ViewToPresenterFavoritesProtocol
protocol ViewToPresenterFavoritesProtocol:TableViewFavoritesProtocol{
    var view : PresenterToViewFavoritesProtocol? {get}
    func viewDidLoad()
}

//MARK: PresenterToViewFavoritesProtocol
protocol PresenterToViewFavoritesProtocol : AnyObject,FavKits {
    func prepareTableView()
    func reloadTableView()
    func reloadIndexPath(indexPath:IndexPath)
    func sendMessage(text:String,isHidden:Bool)
}

//MARK: PresenterToInteractorFavoritesProtocol
protocol PresenterToInteractorFavoritesProtocol{
    func fetchFavorites()
    func deleteFav(id:Int16)
}

//MARK: InteractorToPresenterFavoritesProtocol
protocol InteractorToPresenterFavoritesProtocol : AnyObject{
    func sendFavorites(list:[Favorite])
    
    func sendError()
}

//MARK: PresenterToRouterFavoritesProtocol
protocol PresenterToRouterFavoritesProtocol {
    func toDetailScreen(
        view:PresenterToViewFavoritesProtocol?,
        locationElement:LocationElement)
}
