//
//  JSONDecoder+ContentDecoder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

extension JSONDecoder: PContentDecoder {
    public var supportedContentTypes: Set<String> { [ContentTypes.applicationJson] }
    
    public func decode<T>(_ type: T.Type, from data: Data, contentType: String) throws -> T where T : Decodable {
        guard self.supports(contentType: contentType) else {
            throw ContentDecodingError.unsupportedContentType(supported: self.supportedContentTypes, actual: contentType)
        }
        do {
            return try decode(type, from: data)
        } catch {
            throw ContentDecodingError.decodingFailure(error: error)
        }
    }
}
