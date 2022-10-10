//
//  NetworkManager.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

enum Result<String> {
    case success
    case failure(String)
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "the url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
}

protocol NetworkManagerProtocol {
    func getWinePair(for food: String, completion: @escaping (_ wineData: WineData?, _ error: String?) -> ())
}

struct NetworkManager: NetworkManagerProtocol {
    static let environment: NetworkEnvironment = .production
    static let APIKEY = "e9802a8e37424fb2830664ba7d44e04d"
    private let router = Router<WineEndPoint>()
    
    func getWinePair(for food: String, completion: @escaping (_ wineData: WineData?, _ error: String?) -> ()) {
        router.request(.pairing(food: food)) { data, response, error in
            
            if error != nil {
                completion(nil,  "please check your network connection")
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(WineData.self, from: responseData)
                    completion(apiResponse, nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                completion(nil, networkFailureError)
            }
        }
    }
}
