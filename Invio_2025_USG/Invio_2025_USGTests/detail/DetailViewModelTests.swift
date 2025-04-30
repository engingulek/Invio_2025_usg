//
//  DetailViewModelTests.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import XCTest
@testable import Invio_2025_USG


final class DetailViewModelTests : XCTest {
    private var viewController : MockDetailViewController!
    private var interactor : MockDetailInteractor!
    private var router : DetailRouter!
    private var presenter : DetailPresenter!
    
    
    override func setUp(){
        viewController = .init()
        interactor = .init()
        router = .init()
        presenter = .init(
            view: viewController,
            router: router, interactor: interactor)
        interactor.presenter = presenter
    }
    
    override  func tearDown() {
        viewController = nil
        interactor = nil
        presenter = nil
        router = nil
    }
    
    func test_viewDidLoad_setBackColorAble_ReturnPrimaryBackColor(){
        
        XCTAssertFalse(viewController.invokedsetBackColorAble,"is not false")
        XCTAssertEqual(viewController.invokedsetBackColorAbleCount, 0,"is not zero (0)")
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        
        XCTAssertTrue(viewController.invokedsetBackColorAble,"is not true")
        XCTAssertEqual(viewController.invokedsetBackColorAbleCount, 1,"is not 1")
        
        XCTAssertEqual(viewController.invokedsetBackColorAbleData.map(\.color),
                       [ColorTheme.primaryColor.rawValue],"is not ColorTheme.primaryBackColor.rawValue")
    }
    
    
    
    func test_viewdidlaod_returnNavRightButton_FavIconType() {
        XCTAssertFalse(viewController.invokedSetNavigationRightButton,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 0,"is not zero (0)")
        
        let element = MockPageElements.firstPageElement.data[0].locations[0]
        presenter.getLocationData(element)
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        
        // is not in fav
        interactor.isEntityExistState = false
        
        XCTAssertTrue(viewController.invokedSetNavigationRightButton,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 1,"is not 1")
        
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonParameters.map(\.iconImage),[IconTheme.no_fav.rawValue])
        
        // is  in fav
        
        interactor.isEntityExistState = true
        
        XCTAssertTrue(viewController.invokedSetNavigationRightButton,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 1,"is not 1")
        
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonParameters.map(\.iconImage),[IconTheme.fav.rawValue])
        
    }
    
    
    func test_onTappedRightButtonFavIcon_ReturnFavIconType() {
        let element = MockPageElements.firstPageElement.data[0].locations[0]
        presenter.getLocationData(element)
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        
        //add to fav
        presenter.onTappedFavIcon()
        interactor.isEntityExistState = true
        
        XCTAssertTrue(viewController.invokedSetNavigationRightButton,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 1,"is not 1")
        
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonParameters.map(\.iconImage),[IconTheme.fav.rawValue])
        
        
        // deleteFav
        
        presenter.onTappedFavIcon()
        interactor.isEntityExistState = false
        
        XCTAssertTrue(viewController.invokedSetNavigationRightButton,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 1,"is not 1")
        
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonParameters.map(\.iconImage),[IconTheme.no_fav.rawValue])
        
    }
    
    
    
    @objc func dummyAction() {}
}
