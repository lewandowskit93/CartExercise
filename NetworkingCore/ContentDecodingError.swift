//
//  ContentDecodingError.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public enum ContentDecodingError: Error {
    case emptyPayload
    case unknownContentType
    case unsupportedContentType(supported: Set<String>, actual: String)
    case unsupporedType
    case decodingFailure(error: Error)
}
