//
//  RouteRawRequestEncodedResponseWithContext.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public struct RouteRawRequestEncodedResponseWithContext<Response: Encodable>: PRoute {
    public let path: String
    public let method: HttpMethod
    public let allowsEmptyRequestContent: Bool
    public let allowsEmptyResponseContent: Bool
    public let acceptedContentTypes: Set<String>
    public let responseContentTypes: Set<String>
    public let requestValidator: PHttpRequestValidator
    public let responseValidator: PHttpResponseValidator
    private let handler: (HttpRequest, RequestContext) async throws -> Response
    private let encoder: PContentEncoder
    
    public init(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>,
        responseContentTypes: Set<String>,
        encoder: PContentEncoder,
        handler: nonisolated(nonsending) @escaping (HttpRequest, RequestContext) async throws -> Response)
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
        self.encoder = encoder
    }
    
    public func handle(_ context: RequestContext) async throws -> HttpResponse {
        try requestValidator.validate(request: context.request)
        let payload = try await handler(context.request, context)
        let responseContentType = responseContentTypes.first!
        let rawResponseData = try self.encoder.encode(payload, contentType: responseContentType)
        let rawResponse = HttpResponse(statusCode: .ok, contentType: responseContentType, content: rawResponseData)
        try responseValidator.validate(response: rawResponse)
        return rawResponse
    }
}
