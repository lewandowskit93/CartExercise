//
//  PContentEncoder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

public protocol PContentEncoder {
    var supportedContentTypes: Set<String> { get }
    func encode<T: Encodable>(_ data: T, contentType: String) throws -> Data
}

public extension PContentEncoder {
    func supports(contentType: String) -> Bool {
        return supportedContentTypes.contains(contentType)
    }
}
