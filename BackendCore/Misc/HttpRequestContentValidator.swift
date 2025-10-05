//
//  HttpRequestContentValidator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public struct HttpRequestContentValidator: PHttpRequestValidator {
    public let allowsEmptyRequestContent: Bool
    public let acceptedContentTypes: Set<String>
    
    public init(allowsEmptyRequestContent: Bool, acceptedContentTypes: Set<String>) {
        self.allowsEmptyRequestContent = allowsEmptyRequestContent
        self.acceptedContentTypes = acceptedContentTypes
    }
    
    public func validate(request: HttpRequest) throws {
        if(allowsEmptyRequestContent) {
            return
        } else {
            guard let contentType = request.contentType else {
                throw ContentDecodingError.unknownContentType
            }
            guard let content = request.payload else {
                throw ContentDecodingError.emptyPayload
            }
            guard acceptedContentTypes.contains(contentType) else {
                throw ContentDecodingError.unsupportedContentType(
                    supported: acceptedContentTypes,
                    actual: contentType)
            }
        }
    }
}
