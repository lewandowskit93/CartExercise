//
//  ContentEncodingError.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public enum ContentEncodingError: Error {
    case emptyContent
    case unknownContentType
    case unsupportedContentType(supported: Set<String>, actual: String)
    case unsupporedType
    case encodingFailure(error: Error)
}
