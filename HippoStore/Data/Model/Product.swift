//
//  Product.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation

struct Product: Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

extension Product : Responable, Decodable { }
