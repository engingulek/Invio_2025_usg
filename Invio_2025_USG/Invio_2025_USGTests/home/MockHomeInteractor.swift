//
//  MockHomeInteractor.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
@testable import Invio_2025_USG
class MockHomeInteractor : PresenterToInteractorHomeProtocol {
    var mockFetchError : Bool = false
    
    var mockisEntityExistError : Bool = false
    var isEntityExistState : Bool = false
    
    var mockdeleteFav : Bool = false
    var mockaddToFav: Bool = false
    weak var presenter : InteractorToPresenterHomeProtocol?
    func fetchPage(pageNumber: Int) async {
        if(mockFetchError){
            presenter?.sendError()
        }else{
           
            
            presenter?.sendPage(page: MockPageElements.secondPageElement)
        }
    }
    
    func isEntityExist(id: Int16) -> Bool {
        if(mockisEntityExistError){
            presenter?.sendError()
            return false
        }else{
            return isEntityExistState
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
