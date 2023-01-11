//
//  ProductResponse.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation

struct ProductResponse: Responable {
    let limit: Int
    let skip: Int
    let total: Int
    let products: [Product]
}

extension ProductResponse : Decodable { }
