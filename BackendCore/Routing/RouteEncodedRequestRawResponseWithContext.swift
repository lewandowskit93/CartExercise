//
//  RouteEncodedRequestRawResponseWithContext.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public struct RouteEncodedRequestRawResponseWithContext<Request: Decodable>: PRoute {
    public let path: String
    public let method: HttpMethod
    public let allowsEmptyRequestContent: Bool
    public let allowsEmptyResponseContent: Bool
    public let acceptedContentTypes: Set<String>
    public let responseContentTypes: Set<String>
    public let requestValidator: PHttpRequestValidator
    public let responseValidator: PHttpResponseValidator
    private let handler: (Request, RequestContext) async throws -> HttpResponse
    private let decoder: PContentDecoder
    
    public init(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>,
        responseContentTypes: Set<String>,
        decoder: PContentDecoder,
        handler: nonisolated(nonsending) @escaping (Request, RequestContext) async throws -> HttpResponse)
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
        self.decoder = decoder
    }
    
    public func handle(_ context: RequestContext) async throws -> HttpResponse {
        try requestValidator.validate(request: context.request)
        let requestModel = try self.decoder.decode(Request.self, from: context.request.payload!, contentType: context.request.contentType!)
        let rawResponse = try await handler(requestModel, context)
        try responseValidator.validate(response: rawResponse)
        return rawResponse
    }
}
