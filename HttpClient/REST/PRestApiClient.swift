//
//  PRestApiClient.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public protocol PRestApiClient {
    func get<ResponsePayload: Decodable>(path: String) async throws -> ResponsePayload
    // usually get requests do not have payload, but for simplicity simulating path & query parameters through payload
    func get<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload
    func post<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload
    func put<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload
    func delete<RequestPayload: Encodable, ResponsePayload: Decodable>(path: String, payload: RequestPayload) async throws -> ResponsePayload
}
