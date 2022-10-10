//
//  WineEndPoint.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

enum WineEndPoint {
    case pairing(food: String)
}

extension WineEndPoint: EndPointType {
    var baseURL: URL {
        switch NetworkManager.environment {
        case .production:
            guard let url = URL(string: "https://api.spoonacular.com/food/wine/pairing") else { fatalError("baseURL cannot be configured.") }
            return url
        }
    }
    
    var path: String? {
        switch self {
        case .pairing(let _):
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .pairing:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case.pairing(let food):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: ["food": food], additionHeaders: ["x-api-key": NetworkManager.APIKEY, "Content-Type": "application/json"])
        }
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
}
