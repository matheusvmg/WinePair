//
//  DetailsPagePresenter.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import Foundation

protocol DetailsPagePresenterProtocol {
    func getDetails()
    func goToWebView(link: String)
    func goBack()
    func getTitleLabelValue() -> String?
    func getDescriptionLabelValue() -> String?
    func getPriceLabelValue() -> String?
    func getScoreLabelValue() -> String?
    func getPurchaseLinkValue() -> String?
    var delegate: DetailsPageDelegate! { get set }
}

class DetailsPagePresenter: DetailsPagePresenterProtocol {
    let view: DetailsPageViewController
    let coordinator: DetailsPageCoordinatorProtocol
    private let wineDetails: Wine?
    weak var delegate: DetailsPageDelegate!
    private let alternativeDescriptionText: String?
    
    init(view: DetailsPageViewController, coordinator: DetailsPageCoordinatorProtocol, wineDetails: Wine?, alternativeDescriptionText: String?) {
        self.view = view
        self.coordinator = coordinator
        self.wineDetails = wineDetails
        self.alternativeDescriptionText = alternativeDescriptionText
    }
    
    func getDetails() {
        guard let wineDetails = wineDetails else { return }
        delegate.configureDetailsPage(wineDetails: wineDetails)
    }
    
    func getTitleLabelValue() -> String? {
        guard let wineDetails = wineDetails else { return nil }
        return wineDetails.title
    }
    
    func getDescriptionLabelValue() -> String? {
        guard let description = wineDetails?.description else { return alternativeDescriptionText }
        return description
    }
    
    func getPriceLabelValue() -> String? {
        guard let wineDetails = wineDetails else { return nil }
        return "\(Strings.priceLabel)\(wineDetails.price ?? "")"
    }
    
    func getScoreLabelValue() -> String? {
        guard let wineDetails = wineDetails else { return nil }
        return "\(Strings.scoreLabel)\(String(format: "%.2f", wineDetails.score ?? 0))"
    }
    
    func getPurchaseLinkValue() -> String? {
        guard let wineDetails = wineDetails else { return nil }
        return wineDetails.link
    }
    
    func goToWebView(link: String) {
        coordinator.goToWebView(link: link)
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
