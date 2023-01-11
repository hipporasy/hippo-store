//
//  StoreApi.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation

enum StoreApi {
    case fetchProducts
    case fetchProduct(id: Int)
}

extension StoreApi : Requestable {
    
    var requestUrl: URL {
        .init(string: "https://dummyjson.com")!
    }
    
    var path: String? {
        switch self {
        case .fetchProducts:
            return "products"
        case .fetchProduct(let id):
            return "products/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var header: [String : String] {
        [:]
    }
    
    var parameter: APIRequestParameter? {
        .none
    }
    
    var timeout: TimeInterval? {
        60
    }
    
}
