//
//  DetailsPagePresenterTests.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 07/10/22.
//

import XCTest
@testable import WinePair

final class DetailsPagePresenterTests: XCTestCase, DetailsPageDelegate {

    private var sut: DetailsPagePresenterProtocol!
    private var coordinator: DetailsPageCoordinatorProtocol!
    private var view: DetailsPageViewController!
    private var mockNavigationController: MockUINavigationController!
    private var wineDetails: Wine!

    override func setUp() {
        super.setUp()
        view = DetailsPageViewController()
        mockNavigationController = MockUINavigationController(rootViewController: view)
        coordinator = DetailsPageCoordinator(navigationController: mockNavigationController, wineDetails: getWineDetails(), alternativeDescriptionText: getAlternativeText())
        sut = DetailsPagePresenter(view: view, coordinator: coordinator, wineDetails: getWineDetails(), alternativeDescriptionText: getAlternativeText())
        sut.delegate = self
        view.presenter = sut
    }

    override func tearDown() {
        view = nil
        sut = nil
        coordinator = nil
        mockNavigationController = nil
        super.tearDown()
    }
    
    func testDetailsPagePresenter_WhenGetDetailsIsCalled_ShouldSendTheRightInformationThroughTheDelegate() {
        sut.getDetails()
        
        XCTAssertNotNil(self.wineDetails)
        XCTAssertEqual(self.wineDetails, getWineDetails())
    }
    
    func testDetailsPagePresenter_WhenGoToWebViewIsCalled_ShouldCallGoToWebViewCoordinatorMethod() {
        sut.goToWebView(link: "www.google.com.br")
        
        if let viewController = mockNavigationController.viewControllerPresented as? UINavigationController {
            XCTAssertTrue(viewController.topViewController is WebViewController)
        } else {
            XCTFail("goToWebView Method was not called")
        }
    }
    
    func testDetailsPagePresenter_WhenGoBackIsCalled_ShouldCallGoBackCoordinatorMethod() {
        sut.goBack()
        
        XCTAssertTrue(mockNavigationController.poppedViewController is DetailsPageViewController)
    }
    
    func testDetailsPagePresenter_WhenGetTitleLabelValueIsCalled_ShouldReturnTheTitleInformationCorrectly() {
        let title = sut.getTitleLabelValue()
        
        XCTAssertEqual(title, "Sterling Vineyards Merlot")
    }
    
    func testDetailsPagePresenter_WhenGetDescriptionLabelValueIsCalled_ShouldReturnTheDescriptionInformationCorrectly() {
        let description = sut.getDescriptionLabelValue()
        
        XCTAssertEqual(description, getAlternativeText())
    }
    
    func testDetailsPagePresenter_WhenGetPriceLabelValueIsCalled_ShouldReturnThePriceInformationCorrectly() {
        let price = sut.getPriceLabelValue()
        
        XCTAssertEqual(price, "Price: $28.99")
    }
    
    func testDetailsPagePresenter_WhenGetScoreLabelValueIsCalled_ShouldReturnTheScoreInformationCorrectly() {
        let score = sut.getScoreLabelValue()
        
        XCTAssertEqual(score, "Score: 0.75")
    }
    
    func testDetailsPagePresenter_WhenGetPurchaseLinkValueIsCalled_ShouldReturnThePurchaseInformationCorrectly() {
        let link = sut.getPurchaseLinkValue()
        
        XCTAssertEqual(link, "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20")
    }
    
    private func getWineDetails() -> Wine? {
        return Wine(id: 428278, title: "Sterling Vineyards Merlot", averageRating: 1.0, description: nil, imageUrl: "https://spoonacular.com/productImages/428278-312x231.jpg", link: "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20", price: "$28.99", ratingCount: 1.0, score: 0.75)
    }
    
    private func getAlternativeText() -> String? {
        return "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle."
    }
    
    func configureDetailsPage(wineDetails: Wine) {
        self.wineDetails = wineDetails
    }
}
