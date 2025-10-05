//
//  Inject.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

@propertyWrapper public struct Inject<Dependency> {
    public var wrappedValue: Dependency {
        get {
            return dependency!
        }
        set {
            dependency = newValue
        }
    }
    private let provisionStrategy: ContainerProvisionStrategy
    private var dependency: Dependency?

    public init(_ provisionStrategy: ContainerProvisionStrategy) {
        self.provisionStrategy = provisionStrategy
        switch(provisionStrategy) {
            case .default(false), .fixed(_, false), .dynamic(_, false):
                let container = getContainer(enclosingInstance: nil)
                dependency = loadDependency(from: container)
                break
            default:
                break
        }
    }
    
    private func getContainer(enclosingInstance: PHasDIContainer?) -> PDIContainer {
        switch(provisionStrategy) {
            case .default:
                return DIContainer.defaultContainer
            case .fixed(let container, _):
                return container
            case .dynamic(let provider, _):
                return provider()
            case .enclosingInstance:
                guard let enclosingInstance = enclosingInstance else {
                    fatalError("Cannot load DI container from enclosing type")
                }
                return enclosingInstance.diContainer
        }
    }
    
    private func loadDependency(from container: PDIContainer) -> Dependency {
        do {
            return try container.resolve(Dependency.self)
        }
        catch DependencyResolvingError.missingDependency(let dependencyType) {
            fatalError("Unregistered dependency type \(String(describing: dependencyType))")
        }
        catch DependencyResolvingError.invalidDependency(let expectedType, let actualType) {
            fatalError("Invalid dependency registered \(String(describing: actualType)) while \(String(describing: expectedType)) expected")
        }
        catch {
            fatalError("Unexpected injection failure: \(error.localizedDescription)")
        }
    }
    
    public static subscript<EnclosingSelf>(
          _enclosingInstance enclosingInstance: EnclosingSelf,
          wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Dependency>,
          storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Dependency {
        get {
            let wrapper = enclosingInstance[keyPath: storageKeyPath]
            if let dependency = wrapper.dependency {
                return dependency
            }
            let container = wrapper.getContainer(enclosingInstance: enclosingInstance as? PHasDIContainer)
            let dependency = wrapper.loadDependency(from: container)
            enclosingInstance[keyPath: storageKeyPath].dependency = dependency
            return dependency
        }
        set {
            enclosingInstance[keyPath: storageKeyPath].dependency = newValue
        }
    }
}
