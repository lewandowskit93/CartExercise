//
//  RestApiClient.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

open class RestApiClient: SimpleHttpClient, PRestApiClient {
    private let requestContentType: String
    private let encoder: PContentEncoder
    private let decoder: PContentDecoder
    
    public init(requester: PHttpRequester, interceptors: [any PInterceptor], encoder: PContentEncoder, decoder: PContentDecoder, requestContentType: String) {
        self.encoder = encoder
        self.decoder = decoder
        self.requestContentType = requestContentType
        super.init(requester: requester, interceptors: interceptors)
    }
    
    public func get<ResponsePayload: Decodable>(path: String) async throws -> ResponsePayload {
        let response = try await get(path: path)
        guard response.statusCode.isSuccess else {
            throw RestApiError.notASuccess
        }
        guard let content = response.content, let contentType = response.contentType else {
            throw RestApiError.contentMissing
        }
        return try decoder.decode(ResponsePayload.self, from: content, contentType: contentType)
    }
    
    public func get<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        let response = try await get(path: path, contentType: requestContentType, payload: payloadData)
        guard response.statusCode.isSuccess else {
            throw RestApiError.notASuccess
        }
        guard let content = response.content, let contentType = response.contentType else {
            throw RestApiError.contentMissing
        }
        return try decoder.decode(ResponsePayload.self, from: content, contentType: contentType)
    }
    
    public func post<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        let response = try await post(path: path, contentType: requestContentType, payload: payloadData)
        guard response.statusCode.isSuccess else {
            throw RestApiError.notASuccess
        }
        guard let content = response.content, let contentType = response.contentType else {
            throw RestApiError.contentMissing
        }
        return try decoder.decode(ResponsePayload.self, from: content, contentType: contentType)
    }
    
    public func post<RequestPayload: Encodable>(path: String, payload: RequestPayload) async throws -> HttpResponse {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        return try await post(path: path, contentType: requestContentType, payload: payloadData)
    }
    
    public func put<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        let response = try await put(path: path, contentType: requestContentType, payload: payloadData)
        guard response.statusCode.isSuccess else {
            throw RestApiError.notASuccess
        }
        guard let content = response.content, let contentType = response.contentType else {
            throw RestApiError.contentMissing
        }
        return try decoder.decode(ResponsePayload.self, from: content, contentType: contentType)
    }
    
    public func put<RequestPayload: Encodable>(path: String, payload: RequestPayload) async throws -> HttpResponse {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        return try await put(path: path, contentType: requestContentType, payload: payloadData)
    }
    
    public func delete<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        let response = try await delete(path: path, contentType: requestContentType, payload: payloadData)
        guard response.statusCode.isSuccess else {
            throw RestApiError.notASuccess
        }
        guard let content = response.content, let contentType = response.contentType else {
            throw RestApiError.contentMissing
        }
        return try decoder.decode(ResponsePayload.self, from: content, contentType: contentType)
    }
    
    public func delete<RequestPayload: Encodable>(path: String, payload: RequestPayload) async throws -> HttpResponse {
        let payloadData = try encoder.encode(payload, contentType: requestContentType)
        return try await delete(path: path, contentType: requestContentType, payload: payloadData)
    }
}
