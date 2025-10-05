//
//  PContentDecoder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

public protocol PContentDecoder {
    var supportedContentTypes: Set<String> { get }
    func decode<T: Decodable>(_ type: T.Type, from: Data, contentType: String) throws -> T
}

public extension PContentDecoder {
    func supports(contentType: String) -> Bool {
        return supportedContentTypes.contains(contentType)
    }
}
