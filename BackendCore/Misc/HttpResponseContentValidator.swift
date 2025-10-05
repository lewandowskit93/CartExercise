//
//  HttpResponseContentValidator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public struct HttpResponseContentValidator: PHttpResponseValidator {
    public let allowsEmptyResponse: Bool
    public let acceptedContentTypes: Set<String>
    
    public init(allowsEmptyResponse: Bool, acceptedContentTypes: Set<String>) {
        self.allowsEmptyResponse = allowsEmptyResponse
        self.acceptedContentTypes = acceptedContentTypes
    }
    
    public func validate(response: HttpResponse) throws {
        if(allowsEmptyResponse) {
            return
        } else {
            guard let contentType = response.contentType else {
                throw ContentEncodingError.unknownContentType
            }
            guard let content = response.content else {
                throw ContentEncodingError.emptyContent
            }
            guard acceptedContentTypes.contains(contentType) else {
                throw ContentEncodingError.unsupportedContentType(
                    supported: acceptedContentTypes,
                    actual: contentType)
            }
        }
    }
}
