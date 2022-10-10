//
//  ParameterEncoding.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

public typealias Parameters = [String:Any]

protocol ParameterEncoder {
    static func enconde(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
