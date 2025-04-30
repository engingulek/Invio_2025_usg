//
//  SplashPresenter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

//MARK: - SplashPresenter
final class SplashPresenter {
    weak var view: PresenterToViewSplashProtocol?
    private let interactor : PresenterToInteractorSplashProtocol
    private let router : PresenterToRouterSplashProtocol
    
    init(view: PresenterToViewSplashProtocol?,
         interactor : PresenterToInteractorSplashProtocol,
         router:PresenterToRouterSplashProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func fetchFirtPage() async {
        await interactor.fetchFirstPage()
    }
}

//MARK: - SplashPresenter : ViewToPresenterSplashProtocol
extension SplashPresenter : ViewToPresenterSplashProtocol {
    func viewDidLoad() {
        view?.setBackColorAble(color: ColorTheme.primaryColor.rawValue)
        view?.sendTitle(title:TextTheme.splashTitle.localized,isHidden: false)
        Task {
            await  fetchFirtPage()
        }
    }
}

//MARK: - SplashPresenter : InteractorToPresenterSplashProtocol
extension SplashPresenter : InteractorToPresenterSplashProtocol {
    func sendFirsPage(page: PageElement) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            router.toHomeScreen(view: view,pageElement: page)
        }
    }

    func sendError() {
        view?.sendErrorMessage(text: TextTheme.errorMessage.localized,isHidden: false)
    }
}
