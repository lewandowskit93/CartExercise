//
//  RouterSetupError.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public enum RouterSetupError: Error {
    case routeAlreadyDefined(path: String, method: HttpMethod)
}
