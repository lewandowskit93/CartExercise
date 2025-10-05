//
//  DependencyRegistrationError.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public enum DependencyRegistrationError: Error {
    case invalidInheritance(superType: Any.Type, instanceType: Any.Type)
}
