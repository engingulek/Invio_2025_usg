//
//  DetailPresenter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

final class DetailPresenter {
    
    weak var view: PresenterToViewDetailProtocol?
    private let router : PresenterToRouterDetailProtocol
    private let interactor : PresenterToInteractorDetailProtocol
    private var detail:LocationElement?
    private var rightButtonActionSelector:Selector?
    private var favState : IconTheme = IconTheme.no_fav
    
    init(view: PresenterToViewDetailProtocol?,
         router: PresenterToRouterDetailProtocol,
         interactor : PresenterToInteractorDetailProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension DetailPresenter : ViewToPresenterDetailProtocol {
    
    func onTappedFavIcon() {
        guard let detail = detail else {return}
        if favState == IconTheme.fav {
            interactor.deleteFav(id: Int16(detail.id))
        }else{
            interactor.addToFav(element: detail)
        }
        interactor.isEntityExist(id: Int16(detail.id))
    }
    
    func viewDidLoad(rightButtonAction:Selector) {
        view?.hidedBackAble(isHidden: false)
        guard let element = detail else {return}
        
    
        
        view?.setBackColorAble(color: ColorTheme.primaryColor.rawValue)
     
       
        rightButtonActionSelector = rightButtonAction
        view?.setNavigationTitle(title: element.name)
        view?.sendDetailInfo(imageUrl: element.image, detail: element.description)
        interactor.isEntityExist(id: Int16(element.id))
        
    }
    
    func getLocationData(_ locatonElement: LocationElement) {
        detail = locatonElement
    }
    func onTappednShowOnMapButton() {
        guard let detail = detail else {return}
        router.toLocationMap(view: view, locationElement: detail)
    }
}


extension DetailPresenter : InteractorToPresenterDetailProtocol {
    func sendSuccess(state: Bool) {
         favState = state ? IconTheme.fav : IconTheme.no_fav
        guard let action = rightButtonActionSelector else {return}

        view?.setNavigationRightButton(iconImage:favState.rawValue, onTappedAction: action)
    }
    
    func sendError() {
        guard let action = rightButtonActionSelector else {return}
        view?.setNavigationRightButton(iconImage:IconTheme.no_fav.rawValue, onTappedAction: action)
    }
    
    
}
