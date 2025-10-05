//
//  JSONEncoder+ContentEncoder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

extension JSONEncoder: PContentEncoder {
    public var supportedContentTypes: Set<String> { [ContentTypes.applicationJson] }
    
    public func encode<T>(_ data: T, contentType: String) throws -> Data where T : Encodable {
        guard self.supports(contentType: contentType) else {
            throw ContentEncodingError.unsupportedContentType(supported: self.supportedContentTypes, actual: contentType)
        }
        do {
            return try encode(data)
        } catch {
            throw ContentEncodingError.encodingFailure(error: error)
        }
    }
}
