//
//  HTTPTask.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
