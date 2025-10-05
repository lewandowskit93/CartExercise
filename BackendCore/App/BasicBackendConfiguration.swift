//
//  BasicBackendConfiguration.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public struct BasicBackendConfiguration: PBackendConfiguration {
    public let defaultResponseContentType: String
    
    public init(defaultResponseContentType: String) {
        self.defaultResponseContentType = defaultResponseContentType
    }
}
