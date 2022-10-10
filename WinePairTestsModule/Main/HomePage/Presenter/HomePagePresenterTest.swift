//
//  HomePagePresenterTest.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 07/10/22.
//

import XCTest
@testable import WinePair

final class HomePagePresenterTest: XCTestCase {
    private var sut: HomePagePresenter!
    private var view: HomePageViewController!
    private var coordinator: HomePageCoordinatorProtocol!
    private var networkManager: MockNetworkManager!
    private var mockNavigationController: MockUINavigationController!

    override func setUp() {
        super.setUp()
        view = HomePageViewController()
        networkManager = MockNetworkManager()
        mockNavigationController = MockUINavigationController(rootViewController: view)
        coordinator = HomePageCoordinator(navigationController: mockNavigationController)
        sut = HomePagePresenter(view: view, coordinator: coordinator, networkManager: networkManager)
        view.presenter = sut
    }

    override func tearDown() {
        view = nil
        networkManager = nil
        mockNavigationController = nil
        coordinator = nil
        sut = nil
        super.tearDown()
    }

    func testHomePagePresenter_WhenGetWineMethodCalled_ShouldSetTheCorrectInformationInHomePageViewController() {
        networkManager.httpUrlResponse = HTTPURLResponse(url: URL(string: "https://api.spoonacular.com/food/wine/pairing")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        sut.getWine(for: "steak")
        
        let expectations = self.expectation(description: "Test getWine Method if is passing to completion the right information")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertNotNil(self.sut.view.wineItems)
            XCTAssertNotNil(self.sut.view.wines)
            XCTAssertNotNil(self.sut.view.alternativeDescriptionText)
            
            XCTAssertEqual(self.sut.view.wineItems, [WineCardContent(imageURL: "https://spoonacular.com/productImages/428278-312x231.jpg", name: "Sterling Vineyards Merlot")])
            XCTAssertEqual(self.sut.view.wines, [
                Wine(id: 428278, title: "Sterling Vineyards Merlot", averageRating: 1.0, description: nil, imageUrl: "https://spoonacular.com/productImages/428278-312x231.jpg", link: "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20", price: "$28.99", ratingCount: 1.0, score: 0.75)
            ])
            XCTAssertEqual(self.sut.view.alternativeDescriptionText, "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle.")
            
            expectations.fulfill()
        })
        wait(for: [expectations], timeout: 2.0)
    }
    
    func testHomePagePresenter_WhenGetWineMethodCalledAndResponseStatusCodeIs401_ShouldHandleError() {
        networkManager.httpUrlResponse = HTTPURLResponse(url: URL(string: "https://api.spoonacular.com/food/wine/pairing")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        sut.getWine(for: "steak")
        
        XCTAssertEqual(networkManager.error, NetworkResponse.authenticationError.rawValue)
    }
    
    func testHomePagePresenter_WhenGetWineMethodCalledAndResponseStatusCodeIs501_ShouldHandleError() {
        networkManager.httpUrlResponse = HTTPURLResponse(url: URL(string: "https://api.spoonacular.com/food/wine/pairing")!, statusCode: 501, httpVersion: nil, headerFields: nil)
        sut.getWine(for: "steak")
        
        XCTAssertEqual(networkManager.error, NetworkResponse.badRequest.rawValue)
    }
    
    func testHomePagePresenter_WhenGetWineMethodCalledAndResponseStatusCodeIs600_ShouldHandleError() {
        networkManager.httpUrlResponse = HTTPURLResponse(url: URL(string: "https://api.spoonacular.com/food/wine/pairing")!, statusCode: 600, httpVersion: nil, headerFields: nil)
        sut.getWine(for: "steak")
        
        XCTAssertEqual(networkManager.error, NetworkResponse.outdated.rawValue)
    }
    
    func testHomePagePresenter_WhenGetWineMethodCalledAndResponseStatusCodeIs301_ShouldHandleError() {
        networkManager.httpUrlResponse = HTTPURLResponse(url: URL(string: "https://api.spoonacular.com/food/wine/pairing")!, statusCode: 301, httpVersion: nil, headerFields: nil)
        sut.getWine(for: "steak")
        
        XCTAssertEqual(networkManager.error, NetworkResponse.failed.rawValue)
    }
}
