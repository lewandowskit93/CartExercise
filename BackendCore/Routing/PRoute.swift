//
//  PRoute.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public protocol PRoute {
    var path: String { get }
    var method: HttpMethod { get }
    var allowsEmptyRequestContent: Bool { get }
    var allowsEmptyResponseContent: Bool { get }
    var acceptedContentTypes: Set<String> { get }
    var responseContentTypes: Set<String> { get }
    var requestValidator: PHttpRequestValidator { get }
    var responseValidator: PHttpResponseValidator { get }

    func handle(_ context: RequestContext) async throws -> HttpResponse
}
