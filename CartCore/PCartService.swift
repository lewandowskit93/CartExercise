//
//  PCartService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

public protocol PCartService {
    func getCart() async throws -> Cart
}
