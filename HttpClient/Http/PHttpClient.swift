//
//  PHttpClient.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation
import NetworkingCore

public protocol PHttpClient: PHttpRequester {
    func send(request: HttpRequest) async throws -> HttpResponse
    // usually get requests do not have payload, but for simplicity simulating path & query parameters through payload
    func get(path: String, contentType: String?, payload: Data?) async throws -> HttpResponse
    func post(path: String, contentType: String?, payload: Data?) async throws -> HttpResponse
    func put(path: String, contentType: String?, payload: Data?) async throws -> HttpResponse
    func delete(path: String, contentType: String?, payload: Data?) async throws -> HttpResponse
}

public extension PHttpClient {
    func get(path: String, contentType: String? = nil, payload: Data? = nil) async throws -> HttpResponse {
        let request = HttpRequest(url: path, method: HttpMethod.get, contentType: contentType, payload: payload)
        return try await send(request: request)
    }
    
    func post(path: String, contentType: String? = nil, payload: Data? = nil) async throws -> HttpResponse {
        let request = HttpRequest(url: path, method: HttpMethod.post, contentType: contentType, payload: payload)
        return try await send(request: request)
    }
    
    func put(path: String, contentType: String? = nil, payload: Data? = nil) async throws -> HttpResponse {
        let request = HttpRequest(url: path, method: HttpMethod.put, contentType: contentType, payload: payload)
        return try await send(request: request)
    }
    
    func delete(path: String, contentType: String? = nil, payload: Data? = nil) async throws -> HttpResponse {
        let request = HttpRequest(url: path, method: HttpMethod.delete, contentType: contentType, payload: payload)
        return try await send(request: request)
    }
}
