//
//  DetailsPageSnapShotTest.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 07/10/22.
//

import XCTest
@testable import WinePair
import SnapshotTesting

final class DetailsPageSnapShotTest: XCTestCase {
    private var sut: DetailsPageViewController!
    private var presenter: DetailsPagePresenterProtocol!
    private var coordinator: DetailsPageCoordinatorProtocol!
    private var mockNavigationController: MockUINavigationController!
    private var isRecord: Bool = false

    override func setUp() {
        super.setUp()
        sut = DetailsPageViewController()
        mockNavigationController = MockUINavigationController(rootViewController: sut)
        coordinator = DetailsPageCoordinator(navigationController: mockNavigationController, wineDetails: getWineDetails(), alternativeDescriptionText: getAlternativeText())
        presenter = DetailsPagePresenter(view: sut, coordinator: coordinator, wineDetails: getWineDetails(), alternativeDescriptionText: getAlternativeText())
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        coordinator = nil
        mockNavigationController = nil
        super.tearDown()
    }
    
    func testDetailsPageViewController_WhenBackButtonIsInScreen_ShouldBeCorrect() {
        assertSnapshot(matching: sut.backButton, as: .image, record: isRecord)
    }
    
    func testDetailsPageViewController_WhenImageIsInScreen_ShouldBeCorrect() {
        assertSnapshot(matching: sut.image, as: .image(size: setSize(width: 375, height: 280)), record: isRecord)
    }
    
    func testDetailsPageViewController_WhenTitleLabelIsInScreen_ShouldBeCorrect() {
        sut.titleLabel.text = "Black River Winery Merlot"
        assertSnapshot(matching: sut.titleLabel, as: .image, record: isRecord)
    }
    
    func testDetailsPageViewController_WhenDescriptionLabelIsInScreen_ShouldBeCorrect() {
        sut.descriptionLabel.text = "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle."
        assertSnapshot(matching: sut.descriptionLabel, as: .image, record: isRecord)
    }
    
    func testDetailsPageViewController_WhenPriceLabelIsInScreen_ShouldBeCorrect() {
        sut.priceLabel.text = "$28.99"
        assertSnapshot(matching: sut.priceLabel, as: .image, record: isRecord)
    }
    
    func testDetailsPageViewController_WhenScoreLabelIsInScreen_ShouldBeCorrect() {
        sut.scoreLabel.text = "0.75"
        assertSnapshot(matching: sut.scoreLabel, as: .image, record: isRecord)
    }
    
    private func getWineDetails() -> Wine? {
        return Wine(id: 428278, title: "Sterling Vineyards Merlot", averageRating: 1.0, description: nil, imageUrl: "https://spoonacular.com/productImages/428278-312x231.jpg", link: "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20", price: "$28.99", ratingCount: 1.0, score: 0.75)
    }
    
    private func getAlternativeText() -> String? {
        return "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle."
    }
    
    private func setSize(width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
}
