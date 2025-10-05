//
//  PHttpRequester.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public protocol PHttpRequester {
    func send(request: HttpRequest) async throws -> HttpResponse
}
