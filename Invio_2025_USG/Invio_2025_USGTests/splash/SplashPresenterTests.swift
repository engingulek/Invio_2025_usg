//
//  SplashViewModelTests.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import XCTest
@testable import Invio_2025_USG
final class SplashPresenterTests : XCTestCase {
    private var viewController : MockSplashViewController!
    private var interactor : MockSplashInteractor!
    private var presenter : SplashPresenter!
    private var router:SplashRouter!
    
    
    override  func setUp() {
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
        presenter.viewDidLoad()
        
        XCTAssertTrue(viewController.invokedsetBackColorAble,"is not true")
        XCTAssertEqual(viewController.invokedsetBackColorAbleCount, 1,"is not 1")
        
        XCTAssertEqual(viewController.invokedsetBackColorAbleData.map(\.color),
                       [ColorTheme.primaryColor.rawValue],"is not ColorTheme.primaryBackColor.rawValue")
    }
    
    
    func test_viewDidLoad_BeforeError_RetrunTitle() {
        let expectation = XCTestExpectation(description: "Async task completed")
        XCTAssertFalse(viewController.invokedSendTitle,"is not false")
        XCTAssertEqual(viewController.invokedSendTitleCount,0,"is not zero (0)")
        
       
        presenter.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertTrue(self.viewController.invokedSendTitle,"is not true")
            XCTAssertEqual(self.viewController.invokedSendTitleCount,1,"is not one (1)")
            XCTAssertEqual(self.viewController.invokedSendTitleData.map(\.title), [TextTheme.splashTitle.localized])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_viewDidLoad_IfhasError_ReturnErrorMessage() {
        let expectation = XCTestExpectation(description: "Async task completed")
        XCTAssertFalse(viewController.invokedSendErrorMessage,"is not false")
        XCTAssertEqual(viewController.invokedSendErrorMessageCount,0,"is not zero (0)")
        
        interactor.mockError = true
        presenter.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertTrue(self.viewController.invokedSendErrorMessage,"is not true")
            XCTAssertEqual(self.viewController.invokedSendErrorMessageCount,1,"is not one (1)")
            XCTAssertEqual(self.viewController.invokedSendErrorMessageData.map(\.text), [TextTheme.errorMessage.localized])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
