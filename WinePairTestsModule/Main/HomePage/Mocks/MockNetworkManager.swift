//
//  MockNetworkManager.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 05/10/22.
//

import Foundation
@testable import WinePair

final class MockNetworkManager: NetworkManagerProtocol {
    var httpUrlResponse: HTTPURLResponse!
    var error: String = ""
    
    func getWinePair(for food: String, completion: @escaping (WinePair.WineData?, String?) -> ()) {
        
        let result = self.handleResponseStatusCode(httpUrlResponse.statusCode)
        
        switch result {
        case .success:
            completion(getWineData(), nil)
        case .failure(let errorString):
            error = errorString
        }
    }
    
    private func handleResponseStatusCode(_ statusCode: Int) -> Result<String> {
        switch statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    private func getWineData() -> WineData {
        let apiResponse = WineData(
            pairedWines: [
                "merlot",
                "cabernet sauvignon",
                "pinot noir"
            ],
            pairingText: "Merlot, Cabernet Sauvignon, and Pinot Noir are my top picks for Steak. After all, beef and red wine are a classic combination. Generally, leaner steaks go well with light or medium-bodied reds, such as pinot noir or merlot, while fattier steaks can handle a bold red, such as cabernet sauvingnon. The Sterling Vineyards Merlot with a 5 out of 5 star rating seems like a good match. It costs about 29 dollars per bottle.",
            productMatches: [
                Wine(id: 428278, title: "Sterling Vineyards Merlot", averageRating: 1.0, description: nil, imageUrl: "https://spoonacular.com/productImages/428278-312x231.jpg", link: "https://www.amazon.com/2014-Sterling-Vineyards-Valley-Merlot/dp/B071FP8NPG?tag=spoonacular-20", price: "$28.99", ratingCount: 1.0, score: 0.75)
            ]
        )
        return apiResponse
    }
}
