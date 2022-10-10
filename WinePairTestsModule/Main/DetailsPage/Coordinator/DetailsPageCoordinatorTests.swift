//
//  DetailsPageCoordinatorTest.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 07/10/22.
//

import XCTest
@testable import WinePair

final class DetailsPageCoordinatorTests: XCTestCase {
    private var sut: DetailsPageCoordinatorProtocol!
    private var presenter: DetailsPagePresenterProtocol!
    private var view: DetailsPageViewController!
    private var mockNavigationController: MockUINavigationController!

    override func setUp() {
        super.setUp()
        view = DetailsPageViewController()
        mockNavigationController = MockUINavigationController(rootViewController: view)
        sut = DetailsPageCoordinator(navigationController: mockNavigationController, wineDetails: getWineDetails(), alternativeDescriptionText: getAlternativeText())
        presenter = DetailsPagePresenter(view: view, coordinator: sut, wineDetails: getWineDetails(), alternativeDescriptionText: getAlternativeText())
        view.presenter = presenter
    }

    override func tearDown() {
        view = nil
        presenter = nil
        sut = nil
        mockNavigationController = nil
        super.tearDown()
    }

    func testDetailsPageCoordinator_WhenCallGotToWebViewMethod_ShouldNavigateToWebViewController() {
        sut.goToWebView(link: "www.google.com.br")
        
        if let viewController = mockNavigationController.viewControllerPresented as? UINavigationController {
            XCTAssertTrue(viewController.topViewController is WebViewController)
        } else {
            XCTFail("It's not in NavVC of WebviewController")
        }
    }
    
    func testDetailsPageCoordinator_WhenCallGoBackMethod_ShouldNavigateToHomePageViewController() {        
        sut.goBack()
        
        XCTAssertTrue(mockNavigationController.poppedViewController is DetailsPageViewController)
    }
    
    private func getWineDetails() -> Wine? {
        return Wine(id: 428278, title: "Sterling Vineyards Merlot", averageRating: 1.0, description: nil, imageUrl: "https://spoonacular.com/productImages/428278-312x231.jpg", link: "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20", price: "$28.99", ratingCount: 1.0, score: 0.75)
    }
    
    private func getAlternativeText() -> String? {
        return "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle."
    }
}
