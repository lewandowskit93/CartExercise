//
//  LazySingletonProvider.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//


public class LazySingletonProvider<T>: PDependencyProvider {
    private let container: PDIContainer
    private var value: T!
    private let factory: (PDIContainer) throws -> T
    
    public init(container: PDIContainer, factory: @escaping (PDIContainer) throws -> T) {
        self.container = container
        self.factory = factory
    }
    
    public func provide() throws -> T {
        guard let value = value else {
            let value = try factory(container)
            self.value = value
            return value
        }
        return value
    }
}
