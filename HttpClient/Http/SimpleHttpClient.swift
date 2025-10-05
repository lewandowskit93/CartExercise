//
//  SimpleHttpClient.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

open class SimpleHttpClient: PHttpClient {
    private let requester: PHttpRequester
    private let interceptors: [PInterceptor]
    
    public init(requester: PHttpRequester, interceptors: [PInterceptor]) {
        self.requester = requester
        self.interceptors = interceptors
    }
    
    public func send(request: HttpRequest) async throws -> HttpResponse {
        let preparedRequest = try await prepareRequest(request: request)
        do {
            let response = try await callRequester(request: request)
            try await processResponse(response: response)
            return response
        }
        catch {
            try await processError(error: error)
            throw error
        }
    }
    
    private func processError(error: Error) async throws {
        try await callInterceptorOnError(error: error, interceptorIndex: 0)
    }
    
    private func callInterceptorOnError(error: Error, interceptorIndex: Int) async throws {
        guard interceptorIndex < self.interceptors.count else { return }
        let interceptor = interceptors[interceptorIndex]
        try await interceptor.onError(error: error, next: { [unowned self] in
            try await self.callInterceptorOnError(error: error, interceptorIndex: interceptorIndex + 1)
        })
    }
    
    private func processResponse(response: HttpResponse) async throws {
        try await callInterceptorOnResponse(response: response, interceptorIndex: 0)
    }
    
    private func callInterceptorOnResponse(response: HttpResponse, interceptorIndex: Int) async throws {
        guard interceptorIndex < self.interceptors.count else { return }
        let interceptor = interceptors[interceptorIndex]
        try await interceptor.onResponse(response: response, next: { [unowned self] in
            try await self.callInterceptorOnResponse(response: response, interceptorIndex: interceptorIndex + 1)
        })
    }
    
    private func prepareRequest(request: HttpRequest) async throws -> HttpRequest {
        let processedRequest = try await callInterceptorOnRequest(request: request, interceptorIndex: 0)
        return processedRequest
    }
    
    private func callInterceptorOnRequest(request: HttpRequest, interceptorIndex: Int) async throws -> HttpRequest {
        guard interceptorIndex < self.interceptors.count else { return request }
        var processedRequest = request
        let interceptor = interceptors[interceptorIndex]
        try await interceptor.onRequest(request: request, next: { [unowned self] request in
            processedRequest = try await self.callInterceptorOnRequest(request: request, interceptorIndex: interceptorIndex + 1)
        })
        return processedRequest
    }
    
    private func callRequester(request: HttpRequest) async throws -> HttpResponse {
        try await requester.send(request: request)
    }
}
