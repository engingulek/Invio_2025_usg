//
//  HomePresenterTests.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import XCTest
@testable import Invio_2025_USG

final class HomeViewModelTests : XCTestCase {
    private var viewController : MockHomeViewController!
    private var interactor : MockHomeInteractor!
    private var presenter : HomePresenter!
    private var router : HomeRouter!
    
    
    override func setUp(){
        viewController = .init()
        interactor = .init()
        router = .init()
        presenter = .init(
            view: viewController,
            interactor: interactor,
            router: router)
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
    
    // setNavigationTitle
    //setNavigationRightButton
    // collapseButtonIsHidden
    func test_viewDidload_setNavigation_ReturnHomeNavTitle() {
        XCTAssertFalse(viewController.invokedSetNavigationTitle,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationTitleCount, 0,"is not zero (0)")
        
        XCTAssertFalse(viewController.invokedSetNavigationRightButton,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 0,"is not zero (0)")
        
        XCTAssertFalse(viewController.invokedsetBackColorAble,"is not false")
        XCTAssertEqual(viewController.invokedCollapseButtonIsHiddenCount, 0,"is not zero (0)")
        
        
        
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        
        XCTAssertTrue(viewController.invokedSetNavigationTitle,"is not false")
        XCTAssertEqual(viewController.invokedSetNavigationTitleCount, 1,"is not  (1)")
        XCTAssertEqual(viewController.invokedSetNavigationTitleParameters.map(\.title),
                       [TextTheme.homeNavTitle.localized],"is not TextTheme.homeNavTitle.localized")
        
        XCTAssertTrue(viewController.invokedSetNavigationRightButton,"is not true")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonCount, 1,"is not zero (1)")
        XCTAssertEqual(viewController.invokedSetNavigationRightButtonParameters.map(\.iconImage),
                       [IconTheme.fav.rawValue],"is not IconTheme.fav.rawValue")
        
        XCTAssertTrue(viewController.invokedCollapseButtonIsHidden,"is not true")
        XCTAssertEqual(viewController.invokedCollapseButtonIsHiddenCount, 1,"is not zero (1)")
        XCTAssertEqual(viewController.invokedCollapseButtonIsHiddenParameters.map(\.isHided),
                       [true],"is not true")
        
        
    }
    
    // for city ​​without location
    func test_viewForHeader_ReturnElementAndExpandType() {
        let expectation = XCTestExpectation(description: "Async task completed")
        
        presenter.getFirstList(page:MockPageElements.firstPageElement)
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        // for fetch next page
        presenter.scrollViewDidEnd()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let istanbulSection = self.presenter.viewForHeader(in: 0)
            let cityWithoutLocation = self.presenter.viewForHeader(in: 4)
           
            XCTAssertEqual(istanbulSection.expendType,ExpendType.close,"is not close")
            XCTAssertEqual(cityWithoutLocation.expendType,ExpendType.none,"is not open")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
    }
    
    func test_onTappedSection_returnExpandType() {
       
        
        presenter.getFirstList(page:MockPageElements.firstPageElement)
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        
        // ontapped section index = 1 for open
        presenter.onTappedSection(sectionIndex: 1)
        
       let onTappedSectionOpenItem = self.presenter.viewForHeader(in: 1)
        XCTAssertEqual(onTappedSectionOpenItem.expendType,ExpendType.open)
        
        // close
        presenter.onTappedSection(sectionIndex: 1)
        let onTappedSectionCloseItem = self.presenter.viewForHeader(in: 1)
         XCTAssertEqual(onTappedSectionCloseItem.expendType,ExpendType.close)
    }
    
    
    func test_ontappedFavIconOnCell_AddAndDeleteToFavorites_ReturnChangeFavIcon() {
        
        presenter.getFirstList(page:MockPageElements.firstPageElement)
        presenter.viewDidLoad(rightButtonAction: #selector(dummyAction))
        
        //ontapped favicon for add to Favorites
        let indexPath = IndexPath(row: 0, section: 0)
        presenter.onTappedFavIconOnCell(indexPath: indexPath)
        interactor.isEntityExistState = true
        let item = presenter.cellForItem(at: indexPath)
        XCTAssertEqual(item.favState,FavState.favoritee,"is not FavState.favoritee")
        
        // for delete
        presenter.onTappedFavIconOnCell(indexPath: indexPath)
        interactor.isEntityExistState = false
        let itemA = presenter.cellForItem(at: indexPath)
        XCTAssertEqual(itemA.favState,FavState.noFavorite,"is not FavState.noFavorite")
    }
    
    @objc func dummyAction() {}
}
