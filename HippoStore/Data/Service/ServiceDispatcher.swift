//
//  ServiceDispatcher.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import Combine

// MARK: - Service Dispatcher will be the concrete class for any method we use
/**
In this case I'm using URLSession because I don't wanna add Alamofire or any other library
 */
private let DefaultTimeout: Double = 60

open class ServiceDispatcher<TRequestable: Requestable> : ServiceExecutable {
    
    private let _session: URLSession
    
    init(session: URLSession) {
        self._session = session
    }
    
    func execute<T>(_ request: TRequestable) async throws -> T where T : Responable {
        let urlRequest = self.urlRequest(from: request)
        let (data, _) = try await _session.data(for: urlRequest)
        return try T.decode(data)
    }
    
    func execute<T>(_ request: TRequestable) -> AnyPublisher<T, Error> where T : Responable {
        let urlRequest = self.urlRequest(from: request)
        return _session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .tryMap { try T.decode($0) }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Building the URL Request for URL Session
/**
 We can do the same for Alamofire just simple conforming the Requestable to URLConvertiable
 Or create a function to convert Requestable to URLConvertiable
 And other library we ca figure out after
 
 */
extension ServiceDispatcher {
    
    private func urlRequest(from requestable: Requestable) -> URLRequest {
        var url = requestable.requestUrl
        if let path = requestable.path {
            url = url.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = requestable.timeout ?? DefaultTimeout
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.httpMethod = requestable.httpMethod.rawValue
        requestable.header.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let parameter = requestable.parameter {
            switch parameter {
            case .body(let data):
                urlRequest.httpBody = data
            case .urlQuery(let params):
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components!.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
                components!.percentEncodedQuery = components!.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                urlRequest.url = components?.url
            }
        }
        return urlRequest
    }
    
}
