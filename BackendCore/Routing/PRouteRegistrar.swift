//
//  PRouteRegistrar.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public protocol PRouteRegistrar {
    func registerRoute(route: PRoute) throws
    
    func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping () async throws -> Void
    ) throws
    
    func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  () async throws -> HttpResponse
    ) throws
    
    func registerRoute<ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  () async throws -> ResponseModel
    ) throws
    
    func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (RequestContext) async throws -> Void
    ) throws
    
    func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (RequestContext) async throws -> HttpResponse
    ) throws
    
    func registerRoute<ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> ResponseModel
    ) throws
    
    func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (HttpRequest, RequestContext) async throws -> Void
    ) throws
    
    func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (HttpRequest, RequestContext) async throws -> HttpResponse
    ) throws
    
    func registerRoute<ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (HttpRequest, RequestContext) async throws -> ResponseModel
    ) throws
    
    func registerRoute<RequestModel: Decodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (RequestModel, RequestContext) async throws -> Void
    ) throws
    
    func registerRoute<RequestModel: Decodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (RequestModel, RequestContext) async throws -> HttpResponse
    ) throws
    
    func registerRoute<RequestModel: Decodable, ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping  (RequestModel, RequestContext) async throws -> ResponseModel
    ) throws
}
