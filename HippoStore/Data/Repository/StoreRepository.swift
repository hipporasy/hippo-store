//
//  StoreRepository.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import Combine

protocol StoreRepository : BaseRepository {
    func fetchProducts() async throws -> ProductResponse
    func fetchProduct(id: Int) async throws -> Product
    
    // Alternative
    func fetchProducts() -> AnyPublisher<ProductResponse, Error>
    func fetchProduct(id: Int) -> AnyPublisher<Product, Error>
    
}

class StoreRepositoryImpl: StoreRepository {
    
    private let _service: StoreService
    
    init(service: StoreService) {
        _service = service
    }
    
    func fetchProducts() async throws -> ProductResponse {
        try await _service.execute(.fetchProducts)
    }
    
    func fetchProduct(id: Int) async throws -> Product {
        try await _service.execute(.fetchProduct(id: id))
    }
    
    func fetchProducts() -> AnyPublisher<ProductResponse, Error> {
        _service.execute(.fetchProducts)
    }
    
    func fetchProduct(id: Int) -> AnyPublisher<Product, Error> {
        _service.execute(.fetchProduct(id: id))
    }
}
