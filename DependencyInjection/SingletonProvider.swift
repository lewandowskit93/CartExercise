//
//  SingletonProvider.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public class SingletonProvider<T>: PDependencyProvider {
    private let value: T
    
    public init(value: T) {
        self.value = value
    }
    
    public func provide() throws -> T {
        return value
    }
}
