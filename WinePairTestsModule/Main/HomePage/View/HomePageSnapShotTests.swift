//
//  HomePageSnapShotTests.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 05/10/22.
//

import XCTest
@testable import WinePair
import SnapshotTesting

final class HomePageSnapShotTests: XCTestCase {
    private var sut: HomePageViewController!
    private var presenter: HomePagePresenterProtocol!
    private var coordinator: HomePageCoordinatorProtocol!
    private var mockNavigationController: MockUINavigationController!
    private let mockNetworkManager: NetworkManagerProtocol = MockNetworkManager()
    private var isRecord: Bool = false
    
    override func setUp() {
        super.setUp()
        sut = HomePageViewController()
        mockNavigationController = MockUINavigationController(rootViewController: sut)
        coordinator = HomePageCoordinator(navigationController: mockNavigationController)
        presenter = HomePagePresenter(view: sut, coordinator: coordinator, networkManager: mockNetworkManager)
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        coordinator = nil
        mockNavigationController = nil
        super.tearDown()
    }
    
    func testHomePageViewController_WhenTitleLabelIsInScreen_ShouldBeCorrect() {
        assertSnapshot(matching: sut.titleLabel, as: .image)
    }
    
    func testHomePageViewController_WhenSubtitleLabelIsInScreen_ShouldBeCorrect() {
        assertSnapshot(matching: sut.subtitleLabel, as: .image)
    }
    
    func testHomePageViewController_WhenSearchInputIsInScreen_ShouldBeCorrect() {
        assertSnapshot(matching: sut.searchInput, as: .image(size: setSize(width: 375, height: 50)), record: isRecord)
    }
    
    func testHomePageViewController_WhenSearchButtonIsInScreen_ShouldBeCorrect() {
        assertSnapshot(matching: sut.searchButton, as: .image(size: setSize(width: 70, height: 30)), record: isRecord)
    }
    
    func testHomePageViewController_WhenLoadingViewIsInScreen_ShouldBeCorrect() {
        sut.startLoading()
        assertSnapshot(matching: sut.loading, as: .image(size: setSize(width: 50, height: 50)), record: isRecord)
    }
    
    func testHomePageViewController_WhenEmptyViewIsInScreen_ShouldBeCorrect() {
        let emptyView = EmptyView()
        assertSnapshot(matching: emptyView, as: .image(size: setSize(width: 375, height: 375)), record: isRecord)
    }
    
    func testHomePageViewController_WhenWineGridIsInScreen_ShouldBeCorrect() {
        let wineGrid = WineCardTableViewCell()
        let content = WineCardContent(imageURL: "https://boabebida.com.br/storage/9696/866_Vinho_Concha_Y_Toro_Reservado_Cabernet_Sauvignon_750ml.jpg", name: "Reservado chile")
        wineGrid.configureWineCard(with: content)
        assertSnapshot(matching: wineGrid, as: .image(size: setSize(width: 375, height: 285)), record: isRecord)
    }

    private func setSize(width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
}
