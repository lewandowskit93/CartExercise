//
//  RoutingError.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public enum RoutingError: Error {
    case routeNotFound(path: String, method: HttpMethod)
}
