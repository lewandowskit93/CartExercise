//
//  PDIContainer.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public protocol PDIContainer {
    func registerSingleton<Dependency>(item: Dependency)
    func registerLazySingleton<Dependency>(factory: @escaping (PDIContainer) throws -> Dependency)
    func registerFactory<Dependency>(factory: @escaping (PDIContainer) throws -> Dependency)
    func registerSingleton<Dependency, Abstraction>(as: Abstraction.Type, item: Dependency) throws
    func registerLazySingleton<Dependency, Abstraction>(as: Abstraction.Type, factory: @escaping  (PDIContainer) throws -> Dependency) throws
    func registerFactory<Dependency, Abstraction>(as: Abstraction.Type, factory: @escaping (PDIContainer) throws -> Dependency) throws
    func resolve<T>(_ dependencyType: T.Type) throws -> T
}

