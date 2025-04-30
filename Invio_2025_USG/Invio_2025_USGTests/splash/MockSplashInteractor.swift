//
//  MockSplashInteractor.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
@testable import Invio_2025_USG


class MockSplashInteractor : PresenterToInteractorSplashProtocol {
    var mockError : Bool = false
    var presenter : InteractorToPresenterSplashProtocol?
    func fetchFirstPage() async {
        
        if(mockError) {
            presenter?.sendError()
        }else{
        
            presenter?.sendFirsPage(page: MockPageElements.firstPageElement)
        }
    }
}
