//
//  BaseURLInterceptor.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public class BaseURLInterceptor: PInterceptor {
    private let baseURL: String
    
    public init(baseUrl: String) {
        self.baseURL = baseUrl
    }
    
    public func onRequest(request: HttpRequest, next: nonisolated(nonsending) @escaping (HttpRequest) async throws -> Void) async throws {
        let url = "\(baseURL)\(request.url)"
        let modifiedRequest = request.with(url: url)
        try await next(modifiedRequest)
    }
}
