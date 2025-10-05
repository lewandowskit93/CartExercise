//
//  PHttpRequestValidator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public protocol PHttpRequestValidator {
    func validate(request: HttpRequest) throws
}
