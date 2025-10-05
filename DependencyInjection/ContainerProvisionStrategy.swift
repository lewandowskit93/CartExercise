//
//  ContainerProvisionStrategy.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//


public enum ContainerProvisionStrategy {
    case `default`(lazy: Bool = false)
    case fixed(_ container: PDIContainer, lazy: Bool = false)
    case dynamic(provider: () -> PDIContainer, lazy: Bool = false)
    // always lazy
    case enclosingInstance
}
