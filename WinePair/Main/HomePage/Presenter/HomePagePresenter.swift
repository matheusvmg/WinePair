//
//  HomePagePresenter.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import Foundation

protocol HomePagePresenterProtocol {
    func getWine(for food: String)
    func didSelectWine(with content: Wine, alternativeDescriptionText: String?)
}

class HomePagePresenter: HomePagePresenterProtocol {
    let view: HomePageViewController
    let coordinator: HomePageCoordinatorProtocol
    private let networkManager: NetworkManagerProtocol
    
    init(view: HomePageViewController, coordinator: HomePageCoordinatorProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func getWine(for food: String) {
        view.startLoading()
        let formattedText = food.replacingOccurrences(of: " ", with: "")
        networkManager.getWinePair(for: formattedText) { [weak self] wineData, error in
            guard let self = self else { return }
            guard let _ = error else {
                self.handleWineData(data: wineData)
                return
            }
            self.setError()
        }
    }
    
    private func handleWineData(data: WineData?) {
        guard let productMatches = data?.productMatches,
              let pairingText = data?.pairingText
        else {
            self.setError()
            return
        }
        
        if productMatches.count == 0 {
            self.setError()
            return
        }
        
        let unwrappedWineData = WineData(pairedWines: data?.pairedWines, pairingText: pairingText, productMatches: productMatches)
        self.getListOfWines(wines: unwrappedWineData)
    }
    
    private func getListOfWines(wines: WineData?) {
        guard let unwrappedValue = wines else { return }
        guard let productsMatches = unwrappedValue.productMatches else { return }
        var content: [WineCardContent]?
        
        content = productsMatches.map { wine in
            return WineCardContent(imageURL: wine.imageUrl, name: wine.title)
        }
        
        guard let content = content else { return }
        DispatchQueue.main.async {
            self.view.wineItems = content
            self.view.wines = productsMatches
            self.view.alternativeDescriptionText = unwrappedValue.pairingText
            self.view.stopLoading()
        }
    }
    
    private func setError() {
        DispatchQueue.main.async {
            self.view.setErrorOrNoWine()
        }
    }
    
    func didSelectWine(with content: Wine, alternativeDescriptionText: String?) {
        coordinator.goToDetailsPage(with: content, alternativeDescriptionText: alternativeDescriptionText)
    }
}
