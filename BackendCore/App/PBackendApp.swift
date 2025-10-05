//
//  PBackendApp.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public protocol PBackendApp {
    func handle(request: HttpRequest) async -> HttpResponse
}
