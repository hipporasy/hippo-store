//
//  ServiceExecutable.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import Combine

/**
 MARK: - The service for execute the Api
 For Convenience I created both aysnc way or publisher depends on the user's preferrance
 We could have the callback like completion block as well but that's not ideal for this.
 */
protocol ServiceExecutable {
    
    associatedtype TRequestable: Requestable
    
    func execute<T>(_ request: TRequestable) async throws -> T where T: Responable
    func execute<T>(_ request: TRequestable) -> AnyPublisher<T, Error> where T : Responable
}
