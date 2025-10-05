//
//  FactoryProvider.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public class FactoryProvider<T>: PDependencyProvider {
    private let container: PDIContainer
    private let factory: (PDIContainer) throws -> T
    
    public init(container: PDIContainer, factory: @escaping (PDIContainer) throws -> T) {
        self.container = container
        self.factory = factory
    }
    
    public func provide() throws -> T {
        return try factory(container)
    }
}
