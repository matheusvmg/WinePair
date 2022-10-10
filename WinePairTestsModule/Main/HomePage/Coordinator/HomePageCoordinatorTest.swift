//
//  HomePageCoordinatorTest.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 07/10/22.
//

import XCTest
@testable import WinePair

final class HomePageCoordinatorTest: XCTestCase {
    private var sut: HomePageCoordinatorProtocol!
    private var view: HomePageViewController!
    private var presenter: HomePagePresenter!
    private var networkManager: NetworkManagerProtocol!
    private var mockNavigationController: MockUINavigationController!

    override func setUp() {
        super.setUp()
        view = HomePageViewController()
        networkManager = MockNetworkManager()
        mockNavigationController = MockUINavigationController(rootViewController: view)
        sut = HomePageCoordinator(navigationController: mockNavigationController)
        presenter = HomePagePresenter(view: view, coordinator: sut, networkManager: networkManager)
        view.presenter = presenter
    }

    override func tearDown() {
        view = nil
        networkManager = nil
        mockNavigationController = nil
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testHomePageCoordinator_WhenNavigateToDetailsPageViewController_ViewControllerPushedShouldBeDetailsPageViewController() {
        let content = Wine(id: 428278, title: "Sterling Vineyards Merlot", averageRating: 1.0, description: nil, imageUrl: "https://spoonacular.com/productImages/428278-312x231.jpg", link: "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20", price: "$28.99", ratingCount: 1.0, score: 0.75)
        let alternativeText = "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle."
        sut.goToDetailsPage(with: content, alternativeDescriptionText: alternativeText)
        
        XCTAssertTrue(mockNavigationController.pushedViewController is DetailsPageViewController)
    }
}
