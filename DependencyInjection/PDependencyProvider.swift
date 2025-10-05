//
//  PDependencyProvider.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public protocol PDependencyProvider {
    associatedtype T
    
    func provide() throws -> T
}
