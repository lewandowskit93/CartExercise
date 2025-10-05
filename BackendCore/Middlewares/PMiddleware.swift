//
//  PMiddleware.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public protocol PMiddleware {
    func callAsFunction(requestContext: RequestContext, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws
    
    func handle(requestContext: RequestContext, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws
}

public extension PMiddleware {
    func callAsFunction(requestContext: RequestContext, next: nonisolated(nonsending) @escaping () async throws -> Void) async throws {
        try await handle(requestContext: requestContext, next: next)
    }
}
