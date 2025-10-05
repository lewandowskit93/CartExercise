//
//  RouteNoRequestNoResponseWithoutContext.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public struct RouteNoRequestNoResponseWithoutContext: PRoute {
    public let path: String
    public let method: HttpMethod
    public let allowsEmptyRequestContent: Bool
    public let allowsEmptyResponseContent: Bool
    public let acceptedContentTypes: Set<String>
    public let responseContentTypes: Set<String>
    public let requestValidator: PHttpRequestValidator
    public let responseValidator: PHttpResponseValidator
    private let handler: () async throws -> Void

    public init(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>,
        responseContentTypes: Set<String>,
        handler: nonisolated(nonsending) @escaping () async throws -> Void)
    {
        self.path = path
        self.method = method
        self.allowsEmptyRequestContent = allowsEmptyRequestContent
        self.allowsEmptyResponseContent = allowsEmptyResponseContent
        self.acceptedContentTypes = acceptedContentTypes
        self.responseContentTypes =  responseContentTypes
        self.requestValidator = HttpRequestContentValidator(allowsEmptyRequestContent: allowsEmptyRequestContent, acceptedContentTypes: acceptedContentTypes)
        self.responseValidator = HttpResponseContentValidator(allowsEmptyResponse: allowsEmptyRequestContent, acceptedContentTypes: acceptedContentTypes)
        self.handler = handler
        
    }
    
    public func handle(_ context: RequestContext) async throws -> HttpResponse {
        try requestValidator.validate(request: context.request)
        try await handler()
        let rawResponse = HttpResponse(statusCode: .noContent)
        try responseValidator.validate(response: rawResponse)
        return rawResponse
    }
}
