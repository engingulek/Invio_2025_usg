//
//  FavoritesPresenter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

final class FavoritesPresenter {
    weak var view : PresenterToViewFavoritesProtocol?
    private var interactor : PresenterToInteractorFavoritesProtocol
    private var router : PresenterToRouterFavoritesProtocol
    private var favList : [Favorite] = []
    
    init(view: PresenterToViewFavoritesProtocol?,
         interactor: PresenterToInteractorFavoritesProtocol,
         router : PresenterToRouterFavoritesProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: ViewToPresenterFavoritesProtocol Methods
extension FavoritesPresenter : ViewToPresenterFavoritesProtocol {
 
    func viewDidLoad() {
        interactor.fetchFavorites()
        view?.setBackColorAble(color: ColorTheme.primaryColor.rawValue)
        view?.setNavigationTitle(title: TextTheme.favNavTitle.localized)
        view?.hidedBackAble(isHidden: false)
        view?.prepareTableView()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return favList.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> String {
        let fav = favList[indexPath.row]
        return fav.name ?? ""
    }
    func didSelectRow(at indexPath: IndexPath) {
        let fav = favList[indexPath.row]
        let locationElement = LocationElement(name: fav.name ?? "",
                                              description: fav.description ,
                                              coordinates: CoordinatesElement(
                                                lat: fav.latitude,
                                                lng: fav.longitude),
                                              image: fav.name, id: Int(fav.id))
        router.toDetailScreen(view: view, locationElement: locationElement)
    }
    
    func onTappedFavIcon(indexPath: IndexPath) {
        let id = favList[indexPath.row].id
        interactor.deleteFav(id: id)
        interactor.fetchFavorites()
    }
}

//MARK: InteractorToPresenterFavoritesProtocol Methods
extension FavoritesPresenter : InteractorToPresenterFavoritesProtocol {
 
    func sendFavorites(list: [Favorite]) {
       

        favList = list
        let message = favList.isEmpty ? TextTheme.favEmptyMessage.localized : ""
        let isHidden = !favList.isEmpty
        view?.sendMessage(text: message, isHidden: isHidden)
        view?.reloadTableView()
    }
    
    func sendError() {
        view?.sendMessage(text: TextTheme.errorMessage.localized, isHidden: false)
    }
}
