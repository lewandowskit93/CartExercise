//
//  PInterceptor.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public protocol PInterceptor {
    func onRequest(request: HttpRequest, next: nonisolated(nonsending) @escaping (HttpRequest) async throws -> Void) async throws
    func onResponse(response: HttpResponse, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws
    func onError(error: Error, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws
}

public extension PInterceptor {
    func onRequest(request: HttpRequest, next: nonisolated(nonsending) @escaping (HttpRequest) async throws -> Void) async throws {
        try await next(request)
    }
    
    func onResponse(response: HttpResponse, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws {
        try await next()
    }
    
    func onError(error: Error, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws {
        try await next()
    }
}
