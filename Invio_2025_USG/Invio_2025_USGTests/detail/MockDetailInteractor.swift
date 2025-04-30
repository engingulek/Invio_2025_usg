//
//  MockDetailInteractor.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
@testable import Invio_2025_USG

class MockDetailInteractor : PresenterToInteractorDetailProtocol {
    
    
    var mockisEntityExistError : Bool = false
    var isEntityExistState : Bool = false
    
    var mockdeleteFav : Bool = false
    var mockaddToFav: Bool = false
    
    weak var presenter : InteractorToPresenterDetailProtocol?
    func isEntityExist(id: Int16) {
        
        if(mockisEntityExistError){
            presenter?.sendError()
        }else{
            presenter?.sendSuccess(state: isEntityExistState)
        }
    }

    func deleteFav(id: Int16) {
        if(mockdeleteFav) {
            presenter?.sendError()
        }
    }
    
    func addToFav(element: Invio_2025_USG.LocationElement) {
        if(mockaddToFav){
            presenter?.sendError()
        }
    }
}
