//
//  NetworkRouter.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
