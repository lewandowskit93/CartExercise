//
//  DependencyResolvingError.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public enum DependencyResolvingError: Error {
    case missingDependency(dependencyType: Any.Type)
    case invalidDependency(expectedType: Any.Type, actualType: Any.Type)
    case factoryError(error: Error)
}
