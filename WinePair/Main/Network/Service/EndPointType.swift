//
//  EndPointType.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get } 
}
