//
//  DIContainer.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public class DIContainer: PDIContainer {
    public static let defaultContainer: DIContainer = DIContainer()
    
    private var providers: Dictionary<ObjectIdentifier, any PDependencyProvider>

    
    public init() {
        providers = Dictionary<ObjectIdentifier, any PDependencyProvider>()
    }
    
    public func resolve<T>(_ dependencyType: T.Type = T.self) throws(DependencyResolvingError) -> T {
        guard let provider = providers[ObjectIdentifier(T.self)] else {
            throw DependencyResolvingError.missingDependency(dependencyType: T.self)
        }
        do {
            let rawDependency = try provider.provide()
            guard let dependency = rawDependency as? T else {
                throw DependencyResolvingError.invalidDependency(expectedType: T.self, actualType: type(of: rawDependency))
            }
            return dependency
        }
        catch {
            throw DependencyResolvingError.factoryError(error: error)
        }
    }
    
    public func registerSingleton<Dependency>(item: Dependency) {
        providers[ObjectIdentifier(Dependency.self)] = SingletonProvider(value: item)
    }
    
    // Unfortunately where clausules cannot be used to enforce inheritance like where Dependency: Abstraction
    public func registerSingleton<Dependency, Abstraction>(as: Abstraction.Type, item: Dependency) throws(DependencyRegistrationError) {
        providers[ObjectIdentifier(Abstraction.self)] = SingletonProvider(value: item)
    }
    
    public func registerLazySingleton<Dependency>(factory: @escaping (PDIContainer) throws -> Dependency) {
        providers[ObjectIdentifier(Dependency.self)] = LazySingletonProvider<Dependency>(container: self, factory: factory)
    }
    
    // Unfortunately where clausules cannot be used to enforce inheritance like where Dependency: Abstraction
    public func registerLazySingleton<Dependency, Abstraction>(as: Abstraction.Type, factory: @escaping  (PDIContainer) throws -> Dependency) throws(DependencyRegistrationError)
    {
        providers[ObjectIdentifier(Abstraction.self)] = LazySingletonProvider<Dependency>(container: self, factory: factory)
    }
    
    public func registerFactory<Dependency>(factory: @escaping (PDIContainer) throws -> Dependency) {
        providers[ObjectIdentifier(Dependency.self)] = FactoryProvider<Dependency>(container: self, factory: factory)
    }
    
    // Unfortunately where clausules cannot be used to enforce inheritance like where Dependency: Abstraction
    public func registerFactory<Dependency, Abstraction>(as: Abstraction.Type, factory: @escaping (PDIContainer) throws -> Dependency) throws(DependencyRegistrationError) {
        providers[ObjectIdentifier(Abstraction.self)] = FactoryProvider<Dependency>(container: self, factory: factory)
    }
}
