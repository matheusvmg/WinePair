//
//  Router.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: getURLBasedOnParameters(route: route), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(bodyParameters: let bodyParameters, urlParameters: let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(bodyParameters: let bodyParameters, urlParameters: let urlParameters, additionHeaders: let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func getURLBasedOnParameters(route: EndPoint) -> URL {
        guard let routePath = route.path else {
            return route.baseURL
        }
        
        return route.baseURL.appendingPathComponent(routePath)
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.enconde(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.enconde(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for(key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
