//
//  Responable.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation

/**
 MARK: - Default Decoder
 - Setup for default decoder in here I'm using JSONDecoder
 - We can setup any style of decoding like XML, SwiftyJSON, Manual, ObjectMapper ..etc
 */

private var _decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
}()


protocol Responable {
    static func decode(_ data: Data) throws -> Self
}

extension Array : Responable where Element : Decodable {
    
    static func decode(_ data: Data) throws -> Self {
        return try _decoder.decode(Self.self, from: data)
    }
    
}

extension Responable where Self: Decodable {

    static func decode(_ data: Data) throws -> Self {
        return try _decoder.decode(Self.self, from: data)
    }

}
